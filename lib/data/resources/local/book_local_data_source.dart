import 'package:gutenread/data/model/book_page_meta_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../model/book_local_model.dart';

class BookLocalDataSource {
  static Isar? _isar;

  static Future<Isar>? _isarFuture;

  static Future<Isar> openIsar() {
    if (_isar != null) return Future.value(_isar!);
    _isarFuture ??= _initIsar();
    return _isarFuture!;
  }

  static Future<Isar> _initIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([
      BookLocalModelSchema,
      BookPageMetaModelSchema,
    ], directory: dir.path);
    return _isar!;
  }

  Future<void> insertBooks(List<BookLocalModel> books) async {
    final isar = await openIsar();
    await isar.writeTxn(() async {
      for (var book in books) {
        final exists =
            await isar.bookLocalModels
                .filter()
                .bookIdEqualTo(book.bookId)
                .and()
                .sectionEqualTo(book.section)
                .isNotEmpty();

        if (!exists) {
          await isar.bookLocalModels.put(book);
        }
      }
    });
  }

  Future<List<BookLocalModel>> getBooksBySection(String section) async {
    final isar = await openIsar();
    return isar.bookLocalModels
        .filter()
        .sectionEqualTo(section)
        .sortByDownloadCountDesc()
        .findAll();
  }

  Future<void> toggleFavorite(int bookId) async {
    final isar = await openIsar();
    final book =
        await isar.bookLocalModels.filter().bookIdEqualTo(bookId).findFirst();
    if (book != null) {
      await isar.writeTxn(() async {
        book.isFavorite = !book.isFavorite;
        await isar.bookLocalModels.put(book);
      });
    }
  }

  Future<void> saveLastPage(String section, int page) async {
    final isar = await openIsar();
    final existing =
        await isar.bookPageMetaModels
            .filter()
            .sectionEqualTo(section)
            .findFirst();

    final meta =
        existing ?? BookPageMetaModel()
          ..section = section;
    meta.lastPage = page;

    await isar.writeTxn(() async {
      await isar.bookPageMetaModels.put(meta);
    });
  }

  Future<int> getLastPage(String section) async {
    final isar = await openIsar();
    final meta =
        await isar.bookPageMetaModels
            .filter()
            .sectionEqualTo(section)
            .findFirst();

    return meta?.lastPage ?? 0;
  }
}

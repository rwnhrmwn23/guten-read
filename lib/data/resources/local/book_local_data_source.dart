import 'package:gutenread/data/resources/local/collection/book_meta_collection.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'collection/book_collection.dart';

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
      BookCollectionSchema,
      BookMetaCollectionSchema,
    ], directory: dir.path);
    return _isar!;
  }

  Future<void> insertBooks(List<BookCollection> books) async {
    final isar = await openIsar();
    await isar.writeTxn(() async {
      for (var book in books) {
        final exists =
            await isar.bookCollections
                .filter()
                .bookIdEqualTo(book.bookId)
                .and()
                .sectionEqualTo(book.section)
                .isNotEmpty();

        if (!exists) {
          await isar.bookCollections.put(book);
        }
      }
    });
  }

  Future<List<BookCollection>> getBooksBySection(String section) async {
    final isar = await openIsar();
    return isar.bookCollections
        .filter()
        .sectionEqualTo(section)
        .sortByDownloadCountDesc()
        .findAll();
  }

  Future<BookCollection?> getDetailBookById(int bookId) async {
    final isar = await openIsar();
    return await isar.bookCollections
        .filter()
        .bookIdEqualTo(bookId)
        .findFirst();
  }

  Future<List<BookCollection>> getFavoriteBooks() async {
    final isar = await openIsar();
    return isar.bookCollections
        .filter()
        .isFavoriteEqualTo(true)
        .findAll();
  }

  Future<void> toggleFavorite(int bookId) async {
    final isar = await openIsar();
    final book =
        await isar.bookCollections.filter().bookIdEqualTo(bookId).findFirst();
    if (book != null) {
      await isar.writeTxn(() async {
        book.isFavorite = !book.isFavorite;
        await isar.bookCollections.put(book);
      });
    }
  }

  Future<void> saveLastPage(String section, int page) async {
    final isar = await openIsar();
    final existing =
        await isar.bookMetaCollections
            .filter()
            .sectionEqualTo(section)
            .findFirst();

    final meta =
        existing ?? BookMetaCollection()
          ..section = section;
    meta.lastPage = page;

    await isar.writeTxn(() async {
      await isar.bookMetaCollections.put(meta);
    });
  }

  Future<int> getLastPage(String section) async {
    final isar = await openIsar();
    final meta =
        await isar.bookMetaCollections
            .filter()
            .sectionEqualTo(section)
            .findFirst();

    return meta?.lastPage ?? 0;
  }
}

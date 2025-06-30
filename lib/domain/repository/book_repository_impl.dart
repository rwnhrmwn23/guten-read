import 'package:gutenread/data/model/book_model.dart';
import 'package:gutenread/data/repository/book_repository.dart';
import 'package:gutenread/data/resources/local/book_local_data_source.dart';
import 'package:gutenread/data/resources/local/collection/book_collection.dart';
import 'package:gutenread/data/resources/remote/book_remote_data_source.dart';
import 'package:gutenread/domain/entities/book.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource remote;
  final BookLocalDataSource local;

  BookRepositoryImpl({required this.remote, required this.local});

  @override
  Future<List<Book>> getBooks({String sort = 'popular', int? page}) async {
    try {
      final response = await remote.fetchBooks(sort: sort, page: page);

      final localBooks = response.results.map((e) {
        final entity = e.toEntity();
        final localModel = BookCollection().fromEntity(entity, sort);
        return localModel;
      }).toList();

      await local.insertBooks(localBooks);
      await local.saveLastPage(sort, page ?? 1);

      final localData = await local.getBooksBySection(sort);
      return localData.map((e) => e.toEntity()).toList();
    } catch (e) {
      final localData = await local.getBooksBySection(sort);
      return localData.map((e) => e.toEntity()).toList();
    }
  }

  @override
  Future<Book?> getDetailBookById(int bookId) async {
    final localData = await local.getDetailBookById(bookId);
    return localData?.toEntity();
  }

  @override
  Future<List<Book>> getFavoriteBooks() async {
    final favorites = await local.getFavoriteBooks();
    return favorites.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> saveLastPage(String section, int page) {
    return local.saveLastPage(section, page);
  }

  @override
  Future<int> getLastPage(String section) {
    return local.getLastPage(section);
  }

  @override
  Future<void> toggleFavorite(int bookId) {
    return local.toggleFavorite(bookId);
  }
}

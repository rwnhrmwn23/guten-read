import 'package:gutenread/domain/entities/book.dart';

abstract class BookRepository {
  Future<List<Book>> getBooks({String sort, int? page});
  Future<Book?> getDetailBookById(int bookId);
  Future<List<Book>> getFavoriteBooks();
  Future<int> getLastPage(String sort);
  Future<void> saveLastPage(String section, int page);
  Future<void> toggleFavorite(int bookId);
}
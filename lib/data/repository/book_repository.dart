import 'package:gutenread/domain/entities/book.dart';

abstract class BookRepository {
  Future<List<Book>> getBooks({String sort, int? page});
  Future<int> getLastPage(String sort);
  Future<void> saveLastPage(String section, int page);
}
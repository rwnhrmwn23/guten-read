import 'package:gutenread/domain/entities/book.dart';

abstract class BookRepository {
  Future<List<Book>> getBooks({String sort, int page});
}
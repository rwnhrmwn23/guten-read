import 'package:gutenread/data/model/book_model.dart';
import 'package:gutenread/data/repository/book_repository_impl.dart';
import 'package:gutenread/data/resources/remote/book_remote_data_source.dart';
import 'package:gutenread/domain/entities/book.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource remote;

  BookRepositoryImpl({required this.remote});

  @override
  Future<List<Book>> getBooks({String sort = 'popular', int page = 1}) async {
    final response = await remote.fetchBooks(sort: sort, page: page);
    return response.results.map((e) => e.toEntity()).toList();
  }
}
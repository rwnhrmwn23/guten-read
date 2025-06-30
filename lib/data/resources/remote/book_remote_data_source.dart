import 'package:dio/dio.dart';
import 'package:gutenread/data/model/book_response.dart';

class BookRemoteDataSource {
  static const String baseUrl = 'https://gutendex.com/books';

  final Dio dio;

  BookRemoteDataSource(this.dio);

  Future<BookResponse> fetchBooks({String? sort, int? page}) async {
    final response = await dio.get(
      baseUrl,
      queryParameters: {'sort': sort, 'page': page},
    );
    return BookResponse.fromJson(response.data);
  }

  Future<BookResponse> searchBooks({String? query}) async {
    final response = await dio.get(baseUrl, queryParameters: {'search': query});
    return BookResponse.fromJson(response.data);
  }
}

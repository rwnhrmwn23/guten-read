import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gutenread/data/model/book_response.dart';
import 'package:gutenread/data/resources/remote/book_remote_data_source.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late Dio mockDio;
  late BookRemoteDataSource dataSource;

  setUp(() {
    mockDio = MockDio();
    dataSource = BookRemoteDataSource(mockDio);
  });

  group('BookRemoteDataSource', () {
    final mockJson = {
      "count": 1,
      "next": null,
      "previous": null,
      "results": [
        {
          "id": 1,
          "title": "Mock Book",
          "authors": [
            {"name": "Author One", "birth_year": 1900, "death_year": 1980},
          ],
          "summaries": ["A book summary"],
          "formats": {
            "image/jpeg": "http://example.com/image.jpg",
            "text/html": "http://example.com/text.html",
          },
          "download_count": 100,
        },
      ],
    };

    test('fetchBooks should return BookResponse from Dio', () async {
      when(
        () =>
            mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: mockJson,
          statusCode: 200,
        ),
      );

      final result = await dataSource.fetchBooks(sort: 'popular', page: 1);

      expect(result, isA<BookResponse>());
      expect(result.results.length, 1);
      expect(result.results.first.title, 'Mock Book');
      verify(
        () => mockDio.get(
          BookRemoteDataSource.baseUrl,
          queryParameters: {'sort': 'popular', 'page': 1},
        ),
      ).called(1);
    });

    test('searchBooks should return BookResponse from Dio', () async {
      when(
        () =>
            mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: mockJson,
          statusCode: 200,
        ),
      );

      final result = await dataSource.searchBooks(query: 'flutter');

      expect(result, isA<BookResponse>());
      expect(result.results.first.authors.first.name, 'Author One');
      verify(
        () => mockDio.get(
          BookRemoteDataSource.baseUrl,
          queryParameters: {'search': 'flutter'},
        ),
      ).called(1);
    });
  });
}

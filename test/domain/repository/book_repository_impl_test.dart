import 'package:flutter_test/flutter_test.dart';
import 'package:gutenread/data/model/book_model.dart';
import 'package:gutenread/data/model/book_response.dart';
import 'package:gutenread/data/resources/local/book_local_data_source.dart';
import 'package:gutenread/data/resources/remote/book_remote_data_source.dart';
import 'package:gutenread/domain/entities/book.dart';
import 'package:gutenread/data/resources/local/collection/book_collection.dart';
import 'package:gutenread/domain/repository/book_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockRemote extends Mock implements BookRemoteDataSource {}

class MockLocal extends Mock implements BookLocalDataSource {}

void main() {
  late MockRemote mockRemote;
  late MockLocal mockLocal;
  late BookRepositoryImpl repository;

  setUp(() {
    mockRemote = MockRemote();
    mockLocal = MockLocal();
    repository = BookRepositoryImpl(remote: mockRemote, local: mockLocal);
  });

  group('getBooks()', () {
    const sort = 'popular';
    const page = 1;

    final dummyBookModel = BookModel(
      id: 1,
      title: 'Book 1',
      authors: [
        Author(name: 'Author A', birthYear: 1900, deathYear: 1950)
      ],
      summaries: ['A good book about ...'],
      formats: {
        'image/jpeg': 'http://example.com/image.jpg',
        'text/html': 'http://example.com/book.txt',
      },
      downloadCount: 1000,
    );

    final dummyEntity = dummyBookModel.toEntity();

    final dummyBookCollection = BookCollection().fromEntity(dummyEntity, sort);

    test('should fetch from remote and store to local then return data', () async {
      final remoteResponse = BookResponse(
        count: 1,
        next: null,
        previous: null,
        results: [dummyBookModel],
      );

      when(() => mockRemote
          .fetchBooks(sort: sort, page: page))
          .thenAnswer((_) async => remoteResponse);

      when(() => mockLocal
          .insertBooks(any()))
          .thenAnswer((_) async => {});

      when(() => mockLocal
          .saveLastPage(sort, page))
          .thenAnswer((_) async => {});

      when(() => mockLocal.getBooksBySection(sort))
          .thenAnswer((_) async => [dummyBookCollection]);

      final result = await repository.getBooks(sort: sort, page: page);

      expect(result, isA<List<Book>>());
      expect(result.first.id, dummyEntity.id);
      expect(result.first.title, dummyEntity.title);

      verify(() => mockRemote.fetchBooks(sort: sort, page: page)).called(1);
      verify(() => mockLocal.insertBooks(any())).called(1);
      verify(() => mockLocal.saveLastPage(sort, page)).called(1);
      verify(() => mockLocal.getBooksBySection(sort)).called(1);
    });

    test('should fallback to local when remote throws error', () async {
      when(() => mockRemote
          .fetchBooks(sort: sort, page: page))
          .thenThrow(Exception('API error'));

      when(() => mockLocal
          .getBooksBySection(sort))
          .thenAnswer((_) async => [dummyBookCollection]);

      final result = await repository.getBooks(sort: sort, page: page);

      expect(result, isA<List<Book>>());
      expect(result.length, 1);
      expect(result.first.id, dummyEntity.id);

      verify(() => mockLocal.getBooksBySection(sort)).called(1);
    });
  });

  group('searchBooks()', () {
    const query = 'flutter';

    final dummyBookModel = BookModel(
      id: 2,
      title: 'Flutter for Beginners',
      authors: [
        Author(name: 'John Doe', birthYear: 1980, deathYear: null)
      ],
      summaries: ['A guide to Flutter.'],
      formats: {
        'image/jpeg': 'http://example.com/flutter.jpg',
        'text/html': 'http://example.com/flutter.html',
      },
      downloadCount: 500,
    );

    final dummyEntity = dummyBookModel.toEntity();
    final dummyBookCollection = BookCollection().fromEntity(dummyEntity, 'search');

    test('should return local search result if not empty and not call remote', () async {
      when(() => mockLocal
          .insertSearchHistory(query))
          .thenAnswer((_) async {});
      when(() => mockLocal
          .getBookBySearch(query))
          .thenAnswer((_) async => [dummyBookCollection]);

      final result = await repository.searchBooks(query);

      expect(result, isNotEmpty);
      expect(result.first.title, dummyEntity.title);

      verifyNever(() => mockRemote.searchBooks(query: query));
    });

    test('should fetch from remote if local search is empty', () async {
      final remoteResponse = BookResponse(
        count: 1,
        next: null,
        previous: null,
        results: [dummyBookModel],
      );

      when(() => mockLocal
          .insertSearchHistory(query))
          .thenAnswer((_) async {});
      when(() => mockLocal
          .getBookBySearch(query))
          .thenAnswer((_) async => []);
      when(() => mockRemote
          .searchBooks(query: query))
          .thenAnswer((_) async => remoteResponse);
      when(() => mockLocal.insertBooks(any()))
          .thenAnswer((_) async => {});

      final result = await repository.searchBooks(query);

      expect(result.length, 1);
      expect(result.first.title, dummyEntity.title);

      verify(() => mockRemote.searchBooks(query: query)).called(1);
      verify(() => mockLocal.insertBooks(any())).called(1);
    });

    test('should return empty list if remote and local both fail', () async {
      when(() => mockLocal
          .insertSearchHistory(query))
          .thenAnswer((_) async {});
      when(() => mockLocal
          .getBookBySearch(query))
          .thenAnswer((_) async => []);
      when(() => mockRemote
          .searchBooks(query: query))
          .thenThrow(Exception('Remote error'));

      final result = await repository.searchBooks(query);

      expect(result, isEmpty);
    });
  });

  group('getDetailBookById()', () {
    const bookId = 42;

    final dummyBookModel = BookModel(
      id: bookId,
      title: 'Detail Book',
      authors: [Author(name: 'Author X', birthYear: 1901, deathYear: 1990)],
      summaries: ['Detail book summary'],
      formats: {
        'image/jpeg': 'http://example.com/detail.jpg',
        'text/html': 'http://example.com/detail.html',
      },
      downloadCount: 999,
    );

    final dummyEntity = dummyBookModel.toEntity();
    final dummyCollection = BookCollection().fromEntity(dummyEntity, 'detail');

    test('should return entity from local data source', () async {
      when(() => mockLocal.getDetailBookById(bookId))
          .thenAnswer((_) async => dummyCollection);

      final result = await repository.getDetailBookById(bookId);

      expect(result, isNotNull);
      expect(result!.title, dummyEntity.title);
      verify(() => mockLocal.getDetailBookById(bookId)).called(1);
    });

    test('should return null if no local data found', () async {
      when(() => mockLocal.getDetailBookById(bookId))
          .thenAnswer((_) async => null);

      final result = await repository.getDetailBookById(bookId);

      expect(result, isNull);
      verify(() => mockLocal.getDetailBookById(bookId)).called(1);
    });
  });

  group('getFavoriteBooks()', () {
    final dummyBookModel = BookModel(
      id: 7,
      title: 'Favorite Book',
      authors: [Author(name: 'Fav Author', birthYear: 1960, deathYear: 2020)],
      summaries: ['Fav summary'],
      formats: {
        'image/jpeg': 'http://example.com/fav.jpg',
        'text/html': 'http://example.com/fav.html',
      },
      downloadCount: 777,
    );

    final dummyEntity = dummyBookModel.toEntity();
    final dummyCollection = BookCollection().fromEntity(dummyEntity, 'fav');

    test('should return list of favorite books', () async {
      when(() => mockLocal.getFavoriteBooks())
          .thenAnswer((_) async => [dummyCollection]);

      final result = await repository.getFavoriteBooks();

      expect(result, isA<List<Book>>());
      expect(result.length, 1);
      expect(result.first.title, dummyEntity.title);
      verify(() => mockLocal.getFavoriteBooks()).called(1);
    });
  });

  group('saveLastPage()', () {
    test('should call local.saveLastPage()', () async {
      when(() => mockLocal.saveLastPage('popular', 3))
          .thenAnswer((_) async => {});

      await repository.saveLastPage('popular', 3);

      verify(() => mockLocal.saveLastPage('popular', 3)).called(1);
    });
  });

  group('getLastPage()', () {
    test('should return value from local.getLastPage()', () async {
      when(() => mockLocal.getLastPage('popular'))
          .thenAnswer((_) async => 5);

      final result = await repository.getLastPage('popular');

      expect(result, 5);
      verify(() => mockLocal.getLastPage('popular')).called(1);
    });
  });

  group('toggleFavorite()', () {
    test('should call local.toggleFavorite()', () async {
      when(() => mockLocal.toggleFavorite(999))
          .thenAnswer((_) async => {});

      await repository.toggleFavorite(999);

      verify(() => mockLocal.toggleFavorite(999)).called(1);
    });
  });

}

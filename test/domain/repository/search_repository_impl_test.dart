import 'package:flutter_test/flutter_test.dart';
import 'package:gutenread/domain/repository/search_repository_impl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:gutenread/data/resources/local/book_local_data_source.dart';
import 'package:gutenread/data/resources/local/collection/search_history_collection.dart';

class MockLocal extends Mock implements BookLocalDataSource {}

void main() {
  late SearchRepositoryImpl repository;
  late MockLocal mockLocal;

  setUp(() {
    mockLocal = MockLocal();
    repository = SearchRepositoryImpl(mockLocal);
  });

  group('SearchRepositoryImpl', () {
    test('insertSearchHistory should call local.insertSearchHistory', () async {
      const query = 'flutter';
      when(
        () => mockLocal.insertSearchHistory(query),
      ).thenAnswer((_) async => {});

      await repository.insertSearchHistory(query);

      verify(() => mockLocal.insertSearchHistory(query)).called(1);
    });

    test('deleteSearchQuery should call local.deleteSearchQuery', () async {
      const id = 99;
      when(() => mockLocal.deleteSearchQuery(id)).thenAnswer((_) async => {});

      await repository.deleteSearchQuery(id);

      verify(() => mockLocal.deleteSearchQuery(id)).called(1);
    });

    test(
      'getRecentSearches should return list from local.getRecentSearches',
      () async {
        final dummyHistory =
            SearchHistoryCollection()
              ..id = 1
              ..query = 'flutter';

        when(
          () => mockLocal.getRecentSearches(),
        ).thenAnswer((_) async => [dummyHistory]);

        final result = await repository.getRecentSearches();

        expect(result, isA<List<SearchHistoryCollection>>());
        expect(result.length, 1);
        expect(result.first.query, 'flutter');

        verify(() => mockLocal.getRecentSearches()).called(1);
      },
    );
  });
}

import 'package:gutenread/data/repository/search_repository.dart';
import 'package:gutenread/data/resources/local/collection/search_history_collection.dart';

import '../../data/resources/local/book_local_data_source.dart';

class SearchRepositoryImpl implements SearchRepository {
  final BookLocalDataSource local;

  SearchRepositoryImpl(this.local);

  @override
  Future<void> insertSearchHistory(String query) {
    return local.insertSearchHistory(query);
  }

  @override
  Future<void> deleteSearchQuery(int id) {
    return local.deleteSearchQuery(id);
  }

  @override
  Future<List<SearchHistoryCollection>> getRecentSearches() {
    return local.getRecentSearches();
  }

}
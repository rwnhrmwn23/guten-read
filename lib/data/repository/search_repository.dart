import 'package:gutenread/data/resources/local/collection/search_history_collection.dart';

abstract class SearchRepository {
  Future<void> insertSearchHistory(String query);
  Future<void> deleteSearchQuery(int id);
  Future<List<SearchHistoryCollection>> getRecentSearches();
}
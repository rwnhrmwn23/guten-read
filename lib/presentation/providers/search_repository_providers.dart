import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gutenread/data/repository/search_repository.dart';
import 'package:gutenread/domain/repository/search_repository_impl.dart';
import 'package:gutenread/presentation/providers/book_providers.dart';

import '../../data/resources/local/collection/search_history_collection.dart';
import '../../domain/entities/book.dart';

final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  final local = ref.watch(bookLocalDataSourceProvider);
  return SearchRepositoryImpl(local);
});

final bookSearchProvider = FutureProvider.family.autoDispose<List<Book>, String>((ref, query) async {
  final repo = ref.watch(bookRepositoryProvider);
  return repo.searchBooks(query);
});

final recentSearchesProvider = FutureProvider.autoDispose<List<SearchHistoryCollection>>((ref) async {
  final repo = ref.watch(searchRepositoryProvider);
  return repo.getRecentSearches();
});

final insertSearchQueryProvider = Provider.family<void Function(), String>((ref, query) {
  final repo = ref.watch(searchRepositoryProvider);
  return () => repo.insertSearchHistory(query);
});

final deleteSearchQueryProvider = Provider.family<void Function(), int>((ref, id) {
  final repo = ref.watch(searchRepositoryProvider);
  return () => repo.deleteSearchQuery(id);
});

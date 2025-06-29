import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gutenread/data/repository/book_repository.dart';
import 'package:gutenread/domain/entities/book.dart';

import 'book_providers.dart';

class BookInfinityProviders extends StateNotifier<AsyncValue<List<Book>>> {
  BookInfinityProviders(this._repo, this.sort)
      : super(const AsyncValue.loading()) {
    _fetchInitial();
  }

  final BookRepository _repo;
  final String sort;
  int _currentPage = 1;
  bool _hasNext = true;
  bool _isLoadingMore = false;
  List<Book> _books = [];

  Future<void> _fetchInitial() async {
    try {
      _currentPage = await _repo.getLastPage(sort);

      final localBooks = await _repo.getBooks(sort: sort, page: null);

      if (localBooks.isNotEmpty) {
        _books = localBooks;
        _hasNext = true;
        state = AsyncValue.data(_books);
      } else {
        final result = await _repo.getBooks(sort: sort, page: 1);
        _books = result;
        _currentPage = 1;
        _hasNext = result.isNotEmpty;
        state = AsyncValue.data(_books);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> fetchNextPage() async {
    if (!_hasNext || _isLoadingMore) return;

    _isLoadingMore = true;
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final nextPage = _currentPage + 1;
      final result = await _repo.getBooks(sort: sort, page: nextPage);

      if (result.isEmpty) {
        _hasNext = false;
      } else {
        _books = [..._books, ...result.where((newBook) => !_books.any((book) => book.id == newBook.id))];
        _currentPage = nextPage;
        await _repo.saveLastPage(sort, _currentPage);
        state = AsyncValue.data(_books);
      }
    } catch (e) {
      // Optional: log error
    } finally {
      _isLoadingMore = false;
    }
  }
}

final bookPaginationProvider = StateNotifierProvider.family<
  BookInfinityProviders,
  AsyncValue<List<Book>>,
  String
>((ref, sort) {
  final remote = ref.watch(bookRepositoryProvider);
  return BookInfinityProviders(remote, sort);
});

final isLoadingMoreProvider = StateProvider<bool>((ref) => false);

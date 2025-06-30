import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gutenread/data/repository/book_repository.dart';
import 'package:gutenread/data/resources/local/book_local_data_source.dart';
import 'package:gutenread/data/resources/remote/book_remote_data_source.dart';
import 'package:gutenread/domain/entities/book.dart';
import 'package:gutenread/domain/repository/book_repository_impl.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final bookRemoteDataSourceProvider = Provider<BookRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return BookRemoteDataSource(dio);
});

final bookLocalDataSourceProvider = Provider<BookLocalDataSource>((ref) {
  return BookLocalDataSource();
});

final bookRepositoryProvider = Provider<BookRepository>((ref) {
  final remote = ref.watch(bookRemoteDataSourceProvider);
  final local = ref.watch(bookLocalDataSourceProvider);
  return BookRepositoryImpl(remote: remote, local: local);
});

final bookListProvider = FutureProvider.family<List<Book>, String>((ref, sort) async {
  final repo = ref.watch(bookRepositoryProvider);
  return repo.getBooks(sort: sort);
});

final bookDetailProvider = FutureProvider.family.autoDispose<Book?, int>((ref, bookId) async {
  final repo = ref.watch(bookRepositoryProvider);
  return repo.getDetailBookById(bookId);
});

final favoriteBooksProvider = FutureProvider.autoDispose<List<Book>>((ref) async {
  final repo = ref.watch(bookRepositoryProvider);
  return repo.getFavoriteBooks();
});

final toggleFavoriteProvider = Provider.family<Future<void> Function(), int>((ref, bookId) {
  final repo = ref.watch(bookRepositoryProvider);
  return () => repo.toggleFavorite(bookId);
});

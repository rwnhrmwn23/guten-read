import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gutenread/data/resources/remote/book_remote_data_source.dart';
import 'package:gutenread/domain/entities/book.dart';
import 'package:gutenread/domain/repository/book_repository.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final bookRemoteDataSourceProvider = Provider<BookRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return BookRemoteDataSource(dio);
});

final bookRepositoryProvider = Provider<BookRepositoryImpl>((ref) {
  final remote = ref.watch(bookRemoteDataSourceProvider);
  return BookRepositoryImpl(remote: remote);
});

final bookListProvider = FutureProvider.family<List<Book>, String>((ref, sort) async {
  final repo = ref.watch(bookRepositoryProvider);
  return repo.getBooks(sort: sort);
});
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/book.dart';

part 'book_model.freezed.dart';
part 'book_model.g.dart';

@freezed
class BookModel with _$BookModel {
  const factory BookModel({
    required int id,
    required String title,
    @Default([]) List<Author> authors,
    @Default([]) List<String> summaries,
    @JsonKey(name: 'formats') required Map<String, dynamic> formats,
    @JsonKey(name: 'download_count') @Default(0) int downloadCount,
  }) = _BookModel;

  factory BookModel.fromJson(Map<String, dynamic> json) =>
      _$BookModelFromJson(json);
}

@freezed
class Author with _$Author {
  const factory Author({
    required String name,
    @JsonKey(name: 'birth_year') int? birthYear,
    @JsonKey(name: 'death_year') int? deathYear,
  }) = _Author;

  factory Author.fromJson(Map<String, dynamic> json) =>
      _$AuthorFromJson(json);
}

extension BookModelMapper on BookModel {
  Book toEntity() {
    return Book(
      id: id,
      title: title,
      summary: summaries.isNotEmpty ? summaries[0] : 'No summary available',
      imageUrl: formats["image/jpeg"] ?? '',
      textUrl: formats["text/html"] ?? '',
      author: authors.isNotEmpty ? authors[0].name : 'Unknown',
      birthYear: authors.isNotEmpty ? authors[0].birthYear.toString() : 'Unknown',
      deathYear: authors.isNotEmpty ? authors[0].deathYear.toString() : 'Unknown',
      downloadCount: downloadCount,
    );
  }
}
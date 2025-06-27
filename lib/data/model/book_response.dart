import 'package:freezed_annotation/freezed_annotation.dart';
import 'book_model.dart';

part 'book_response.freezed.dart';
part 'book_response.g.dart';

@freezed
class BookResponse with _$BookResponse {
  const factory BookResponse({
    required int count,
    String? next,
    String? previous,
    required List<BookModel> results,
  }) = _BookResponse;

  factory BookResponse.fromJson(Map<String, dynamic> json) =>
      _$BookResponseFromJson(json);
}
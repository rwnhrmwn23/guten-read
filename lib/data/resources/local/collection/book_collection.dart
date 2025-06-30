import 'package:isar/isar.dart';

import '../../../../domain/entities/book.dart';

part 'book_collection.g.dart';

@collection
class BookCollection {
  Id id = Isar.autoIncrement;

  late int bookId;
  late String title;
  late String summary;
  late String imageUrl;
  late String textUrl;
  late String author;
  late String birthYear;
  late String deathYear;
  late int downloadCount;
  bool isFavorite = false;
  @Index()
  late String section;
}

extension BookLocalMapper on BookCollection {
  Book toEntity() {
    return Book(
      id: bookId,
      title: title,
      summary: summary,
      imageUrl: imageUrl,
      textUrl: textUrl,
      author: author,
      birthYear: birthYear,
      deathYear: deathYear,
      downloadCount: downloadCount,
      isFavorite: isFavorite,
    );
  }

  BookCollection fromEntity(Book book, String section) {
    return BookCollection()
      ..bookId = book.id
      ..title = book.title
      ..summary = book.summary
      ..imageUrl = book.imageUrl
      ..textUrl = book.textUrl
      ..author = book.author
      ..birthYear = book.birthYear
      ..deathYear = book.deathYear
      ..downloadCount = book.downloadCount
      ..isFavorite = book.isFavorite
      ..section = section;
  }
}

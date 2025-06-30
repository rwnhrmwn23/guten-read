import 'package:isar/isar.dart';

part 'book_meta_collection.g.dart';

@collection
class BookMetaCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String section;
  late int lastPage;
}

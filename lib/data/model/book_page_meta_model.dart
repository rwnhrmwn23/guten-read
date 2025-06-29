import 'package:isar/isar.dart';

part 'book_page_meta_model.g.dart';

@collection
class BookPageMetaModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String section;
  late int lastPage;
}

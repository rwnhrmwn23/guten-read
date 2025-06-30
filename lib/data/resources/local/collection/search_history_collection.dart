import 'package:isar/isar.dart';

part 'search_history_collection.g.dart';

@collection
class SearchHistoryCollection {
  @Index()
  Id id = Isar.autoIncrement;

  late String query;
}

import 'package:intl/intl.dart';

import '../domain/entities/book.dart';

String formatNumber(int value) {
  final formatter = NumberFormat('#,###');
  return formatter.format(value);
}

String authorAndYearInfo(Book? book) {
  if (book == null) return "";

  final author = book.author;
  final birth = book.birthYear;
  final death = book.deathYear;

  String yearInfo = "";
  if (birth != "null") {
    final deathDisplay = (death == "null") ? "-" : death;
    yearInfo = " ($birth - $deathDisplay)";
  }

  return "$author$yearInfo";
}
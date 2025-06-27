import 'package:intl/intl.dart';

String formatNumber(int value) {
  final formatter = NumberFormat('#,###');
  return formatter.format(value);
}
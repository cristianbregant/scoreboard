import 'package:intl/intl.dart';

/// Medium date in the current locale, e.g. "25 set 2026" or "Sep 25, 2026".
String formatDate(DateTime? date) {
  if (date == null) return '-';
  return DateFormat.yMMMd().format(date);
}

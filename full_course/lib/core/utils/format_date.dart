import 'package:intl/intl.dart';

String formatDateByYYYYMMDD(DateTime date) {
  return DateFormat('yyyy. MM. dd').format(date);
}

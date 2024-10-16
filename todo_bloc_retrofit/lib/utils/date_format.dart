String dateFormat(String date) {
  final newDate = DateTime.parse(date);

  return '${newDate.year}-${newDate.month}-${newDate.day}';
}

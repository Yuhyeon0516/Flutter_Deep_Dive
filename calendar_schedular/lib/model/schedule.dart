import 'package:calendar_schedular/model/category.dart';
import 'package:drift/drift.dart';

class ScheduleTable extends Table {
  // final int id;
  IntColumn get id => integer().autoIncrement()();

  // final int startTime;
  IntColumn get startTime => integer()();

  // final int endTime;
  IntColumn get endTime => integer()();

  // final String content;
  TextColumn get content => text()();

  // final DateTime date;
  DateTimeColumn get date => dateTime()();

  // final String color;
  // TextColumn get color => text()();
  IntColumn get colorId => integer().references(CategoryTable, #id)();

  // final DateTime createdAt;
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now().toUtc())();
}

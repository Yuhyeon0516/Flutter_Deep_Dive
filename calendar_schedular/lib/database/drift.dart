import 'dart:io';
import 'package:calendar_schedular/model/schedule.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'drift.g.dart';

@DriftDatabase(
  tables: [
    ScheduleTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  Future<List<ScheduleTableData>> getSchedules(DateTime date) =>
      (select(scheduleTable)..where((table) => table.date.equals(date))).get();

  Stream<List<ScheduleTableData>> streamSchedules(DateTime date) =>
      (select(scheduleTable)
            ..where((table) => table.date.equals(date))
            ..orderBy(
              [
                (table) => OrderingTerm(
                    expression: table.startTime, mode: OrderingMode.asc),
                (table) => OrderingTerm(
                    expression: table.endTime, mode: OrderingMode.asc),
              ],
            ))
          .watch();

  Future<int> createSchedule(ScheduleTableCompanion data) =>
      into(scheduleTable).insert(data);

  Future<int> removeSchedule(int id) =>
      (delete(scheduleTable)..where((table) => table.id.equals(id))).go();

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    final cachebase = (await getTemporaryDirectory()).path;

    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
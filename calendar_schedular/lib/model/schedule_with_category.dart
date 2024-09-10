import 'package:calendar_schedular/database/drift.dart';

class ScheduleWithCategory {
  final CategoryTableData category;
  final ScheduleTableData schedule;

  ScheduleWithCategory({
    required this.category,
    required this.schedule,
  });
}

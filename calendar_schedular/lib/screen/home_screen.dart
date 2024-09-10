import 'package:calendar_schedular/component/calendar.dart';
import 'package:calendar_schedular/component/schedule_bottom_sheet.dart';
import 'package:calendar_schedular/component/schedule_card.dart';
import 'package:calendar_schedular/component/today_banner.dart';
import 'package:calendar_schedular/const/color.dart';
import 'package:calendar_schedular/database/drift.dart';
import 'package:calendar_schedular/model/schedule.dart';
import 'package:calendar_schedular/model/schedule_with_category.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet<ScheduleTable>(
            context: context,
            builder: (BuildContext context) {
              return ScheduleBottomSheet(selectedDay: selectedDay);
            },
          );
        },
        backgroundColor: primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Calendar(
              focusedDay: DateTime.now(),
              onDaySelected: onDaySelected,
              selectedDayPredicate: selectedDayPredicate,
            ),
            StreamBuilder<List<ScheduleWithCategory>>(
              stream: GetIt.I<AppDatabase>().streamSchedules(selectedDay),
              builder: (context, snapshot) {
                return TodayBanner(
                  selectedDay: selectedDay,
                  taskCount: !snapshot.hasData ? 0 : snapshot.data!.length,
                );
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                child: StreamBuilder<List<ScheduleWithCategory>>(
                    stream: GetIt.I<AppDatabase>().streamSchedules(selectedDay),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }

                      if (snapshot.data == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final schedules = snapshot.data!;

                      return ListView.separated(
                        itemCount: schedules.length,
                        itemBuilder: (context, index) {
                          final scheduleWithCategory = schedules[index];
                          final schedule = scheduleWithCategory.schedule;
                          final category = scheduleWithCategory.category;

                          return Dismissible(
                            key: ObjectKey(schedule.id),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              GetIt.I<AppDatabase>()
                                  .removeSchedule(schedule.id);
                            },
                            child: GestureDetector(
                              onTap: () async {
                                await showModalBottomSheet<ScheduleTable>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ScheduleBottomSheet(
                                      selectedDay: selectedDay,
                                      id: schedule.id,
                                    );
                                  },
                                );
                              },
                              child: ScheduleCard(
                                startTime: schedule.startTime,
                                endTime: schedule.endTime,
                                content: schedule.content,
                                color: Color(
                                  int.parse(
                                    'FF${category.color}',
                                    radix: 16,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 8,
                          );
                        },
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
    });
  }

  bool selectedDayPredicate(DateTime day) {
    return day.isAtSameMomentAs(selectedDay);
  }
}

import 'package:calendar_schedular/component/calendar.dart';
import 'package:calendar_schedular/component/schedule_bottom_sheet.dart';
import 'package:calendar_schedular/component/schedule_card.dart';
import 'package:calendar_schedular/component/today_banner.dart';
import 'package:calendar_schedular/const/color.dart';
import 'package:calendar_schedular/model/schedule.dart';
import 'package:flutter/material.dart';

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

  Map<DateTime, List<Schedule>> schedules = {
    DateTime.utc(2024, 9, 9): [
      Schedule(
        id: 1,
        startTime: 11,
        endTime: 12,
        content: "플러터 공부하기",
        date: DateTime.utc(2024, 9, 9),
        color: categoryColors.first,
        createdAt: DateTime.now().toUtc(),
      ),
      Schedule(
        id: 2,
        startTime: 14,
        endTime: 16,
        content: "NestJS 공부하기",
        date: DateTime.utc(2024, 9, 9),
        color: categoryColors[3],
        createdAt: DateTime.now().toUtc(),
      ),
      Schedule(
        id: 3,
        startTime: 16,
        endTime: 18,
        content: "운동하기",
        date: DateTime.utc(2024, 9, 9),
        color: categoryColors[5],
        createdAt: DateTime.now().toUtc(),
      ),
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return const ScheduleBottomSheet();
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
            TodayBanner(
              selectedDay: selectedDay,
              taskCount: 0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                child: ListView.separated(
                  itemCount: schedules.containsKey(selectedDay)
                      ? schedules[selectedDay]!.length
                      : 0,
                  itemBuilder: (context, index) {
                    final schedule = schedules[selectedDay]![index];
                    return ScheduleCard(
                      startTime: schedule.startTime,
                      endTime: schedule.endTime,
                      content: schedule.content,
                      color: Color(
                        int.parse(
                          'FF${schedule.color}',
                          radix: 16,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 8,
                    );
                  },
                ),
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

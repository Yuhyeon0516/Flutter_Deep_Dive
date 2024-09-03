import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        bottom: false,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              _Top(
                selectedDate: selectedDate,
                onPressed: onHeartPressed,
              ),
              const _Bottom(),
            ],
          ),
        ),
      ),
    );
  }

  void onHeartPressed() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime date) {
                setState(() {
                  selectedDate = date;
                });
              },
              initialDateTime: selectedDate,
              maximumDate: DateTime.now(),
              dateOrder: DatePickerDateOrder.ymd,
            ),
          ),
        );
      },
      // dialog 외부를 눌렀을때 dismiss할건지
      barrierDismissible: true,
    );
  }
}

class _Bottom extends StatelessWidget {
  const _Bottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Image.asset("asset/img/middle_image.png"),
    );
  }
}

class _Top extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onPressed;

  const _Top({
    super.key,
    required this.selectedDate,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Column(
        children: [
          Text(
            "U & I",
            style: textTheme.displayLarge,
          ),
          Text(
            "우리 처음 만난날",
            style: textTheme.bodyLarge,
          ),
          Text(
            '${selectedDate.year}.${selectedDate.month}.${selectedDate.day}',
            style: textTheme.bodyMedium,
          ),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.favorite,
            ),
            iconSize: 60,
            color: Colors.red,
          ),
          Text(
            "D+${now.difference(selectedDate).inDays + 1}",
            style: textTheme.displayMedium,
          )
        ],
      ),
    );
  }
}

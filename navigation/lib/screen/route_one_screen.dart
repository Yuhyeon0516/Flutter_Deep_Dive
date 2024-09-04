import 'package:flutter/material.dart';
import 'package:navigation/layout/default_layout.dart';
import 'package:navigation/screen/route_two_screen.dart';

class RouteOneScreen extends StatelessWidget {
  final int number;

  const RouteOneScreen({
    super.key,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // system의 뒤로가기를 막음
      // ios의 좌 -> 우 스와이프, android의 뒤로가기 버튼
      canPop: false,
      child: DefaultLayout(
        title: "Route One Screen",
        children: [
          Text(
            "argument: $number",
            textAlign: TextAlign.center,
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop(456);
            },
            child: const Text("Pop"),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const RouteTwoScreen();
                  },
                  settings: const RouteSettings(
                    arguments: 789,
                  ),
                ),
              );
            },
            child: const Text("Push"),
          ),
        ],
      ),
    );
  }
}

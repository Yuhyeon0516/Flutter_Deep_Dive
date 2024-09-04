import 'package:flutter/material.dart';
import 'package:navigation/layout/default_layout.dart';

class RouteTwoScreen extends StatelessWidget {
  const RouteTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;

    return DefaultLayout(
      title: "Route Two Screen",
      children: [
        Text(
          arguments.toString(),
          textAlign: TextAlign.center,
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Pop"),
        ),
        OutlinedButton(
          onPressed: () {
            // named routes
            Navigator.of(context).pushNamed(
              "/three",
              arguments: 1111111,
            );
          },
          child: const Text("Push Route Three"),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(
              "/three",
              arguments: 321321321312,
            );
          },
          child: const Text("Push Replacement"),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil('/three', (route) {
              // Route Stack에서 삭제를 할거면 false
              // 삭제를 안할거면 true를 반환
              // if (route.settings.name == "/") return true;

              // return false;

              return route.settings.name == '/';
            });
          },
          child: const Text("Push And Remove Until"),
        ),
      ],
    );
  }
}

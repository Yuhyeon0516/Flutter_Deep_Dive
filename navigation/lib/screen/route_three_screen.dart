import 'package:flutter/material.dart';
import 'package:navigation/layout/default_layout.dart';

class RouteThreeScreen extends StatelessWidget {
  const RouteThreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    return DefaultLayout(
      title: "Route Three Screen",
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
      ],
    );
  }
}

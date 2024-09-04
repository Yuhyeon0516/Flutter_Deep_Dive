import 'package:flutter/material.dart';
import 'package:navigation/layout/default_layout.dart';
import 'package:navigation/screen/route_one_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "Home Screen",
      children: [
        OutlinedButton(
          onPressed: () async {
            final result = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const RouteOneScreen(
                    number: 20,
                  );
                },
              ),
            );

            print(result);
          },
          child: const Text("Push"),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop(456);
          },
          child: const Text("Pop"),
        ),
        OutlinedButton(
          onPressed: () {
            // pop을 할 수 있다면 pop을 진행
            Navigator.of(context).maybePop();
          },
          child: const Text("Maybe Pop"),
        ),
        OutlinedButton(
          onPressed: () {
            // pop을 할 수 있는지 확인 후 boolean 반환
            print(Navigator.of(context).canPop());
          },
          child: const Text("Can Pop"),
        ),
      ],
    );
  }
}

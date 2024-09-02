import 'dart:async';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? timer;
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(seconds: 2),
      (timer) {
        int currentPage = controller.page!.toInt();
        int nextPage = currentPage + 1;

        if (nextPage > 4) {
          nextPage = 0;
        }

        controller.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.linear,
        );
      },
    );
  }

  @override
  void dispose() {
    // memory leak이 발생할 수 있으니 timer나 controller는 dispose될때 모두 같이 없애주기
    if (timer != null) {
      timer!.cancel();
    }
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: [1, 2, 3, 4, 5]
            .map((e) => Image.asset(
                  "asset/img/image_$e.jpeg",
                  fit: BoxFit.cover,
                ))
            .toList(),
      ),
    );
  }
}

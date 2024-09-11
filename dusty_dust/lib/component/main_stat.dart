import 'package:flutter/material.dart';

class MainStat extends StatelessWidget {
  const MainStat({super.key});

  @override
  Widget build(BuildContext context) {
    const ts = TextStyle(
        color: Colors.white, fontSize: 40, fontWeight: FontWeight.w700);

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const Text(
              "서울",
              style: ts,
            ),
            Text(
              "2024-09-11 21:00",
              style: ts.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              "asset/img/good.png",
              width: MediaQuery.of(context).size.width / 2,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "보통",
              style: ts,
            ),
            Text(
              "나쁘지 않네요.",
              style: ts.copyWith(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

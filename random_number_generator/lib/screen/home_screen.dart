import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_number_generator/component/number_to_image.dart';
import 'package:random_number_generator/constant/color.dart';
import 'package:random_number_generator/screen/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> numbers = [123, 456, 789];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Header(
                onPressed: onSettingPressed,
              ),
              _Body(
                numbers: numbers,
              ),
              _Footer(
                onPressed: onCreatePressed,
              ),
            ],
          ),
        ),
      ),
    );
  }

  onCreatePressed() {
    final rand = Random();
    final Set<int> newNumbers = {};

    while (newNumbers.length < 3) {
      final randNumber = rand.nextInt(1000);

      newNumbers.add(randNumber);
    }

    setState(() {
      numbers = newNumbers.toList();
    });
  }

  onSettingPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const SettingScreen();
        },
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onPressed;
  const _Footer({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: redColor,
        foregroundColor: Colors.white,
      ),
      child: const Text(
        "생성하기",
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final List<int> numbers;
  const _Body({super.key, required this.numbers});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: numbers.map((e) => NumberToImage(number: e)).toList(),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onPressed;
  const _Header({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "랜덤 숫자 생성기",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.settings,
          ),
          color: redColor,
        )
      ],
    );
  }
}

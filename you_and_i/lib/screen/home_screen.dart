import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        bottom: false,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: const Column(
            children: [
              _Top(),
              _Bottom(),
            ],
          ),
        ),
      ),
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
  const _Top({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            "2023.02.11",
            style: textTheme.bodyMedium,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite,
            ),
            iconSize: 60,
            color: Colors.red,
          ),
          Text(
            "D+1",
            style: textTheme.displayMedium,
          )
        ],
      ),
    );
  }
}

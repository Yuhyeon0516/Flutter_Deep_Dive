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
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      "U & I",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "parisienne",
                        fontSize: 72,
                      ),
                    ),
                    const Text(
                      "우리 처음 만난날",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "sunflower",
                        fontSize: 32,
                      ),
                    ),
                    const Text(
                      "2023.02.11",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "sunflower",
                        fontSize: 18,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite,
                      ),
                      iconSize: 60,
                      color: Colors.red,
                    ),
                    const Text(
                      "D+1",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "sunflower",
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Image.asset("asset/img/middle_image.png"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

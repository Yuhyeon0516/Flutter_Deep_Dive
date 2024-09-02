import 'package:flutter/material.dart';
import "package:row_and_column/const/colors.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: colors
                    .map(
                      (e) => Container(
                        width: 50,
                        height: 50,
                        color: e,
                      ),
                    )
                    .toList(),
              ),
              Container(
                width: 50,
                height: 50,
                color: colors[1],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: colors
                    .map(
                      (e) => Container(
                        width: 50,
                        height: 50,
                        color: e,
                      ),
                    )
                    .toList(),
              ),
              Container(
                width: 50,
                height: 50,
                color: colors[3],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

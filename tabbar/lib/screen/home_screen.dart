import 'package:flutter/material.dart';
import 'package:tabbar/screen/basic_tabbar_screen.dart';
import 'package:tabbar/screen/bottom_navigation_bar_screen.dart';
import 'package:tabbar/screen/tabbar_using_controller_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const BasicTabbarScreen(),
                  ),
                );
              },
              child: const Text("Basic Tabbar Screen"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const TabbarUsingControllerScreen(),
                  ),
                );
              },
              child: const Text("Tabbar Using Controller Screen"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const BottomNavigationBarScreen(),
                  ),
                );
              },
              child: const Text("Bottom Navigation Bar Screen"),
            ),
          ],
        ),
      ),
    );
  }
}

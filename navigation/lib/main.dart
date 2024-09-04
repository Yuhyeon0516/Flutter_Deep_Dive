import 'package:flutter/material.dart';
import 'package:navigation/screen/home_screen.dart';
import 'package:navigation/screen/route_one_screen.dart';
import 'package:navigation/screen/route_three_screen.dart';
import 'package:navigation/screen/route_two_screen.dart';

// imperative vs declarative
void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: HomeScreen(),
      initialRoute: "/",
      routes: {
        // key - route name, value - builder
        "/": (BuildContext context) => const HomeScreen(),
        "/one": (BuildContext context) => const RouteOneScreen(
              number: 999,
            ),
        "/two": (BuildContext context) => const RouteTwoScreen(),
        "/three": (BuildContext context) => const RouteThreeScreen(),
      },
    ),
  );
}

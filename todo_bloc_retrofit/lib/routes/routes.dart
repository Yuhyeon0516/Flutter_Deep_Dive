import 'package:flutter/material.dart';
import 'package:todo_bloc_retrofit/routes/route_name.dart';
import 'package:todo_bloc_retrofit/screens/home_screen.dart';
import 'package:todo_bloc_retrofit/screens/no_route_found.dart';

class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.homeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const NoRouteFound(),
        );
    }
  }
}

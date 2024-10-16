import 'package:flutter/material.dart';
import 'package:todo_bloc_retrofit/routes/route_name.dart';
import 'package:todo_bloc_retrofit/screens/add_and_update_todo_screen.dart';
import 'package:todo_bloc_retrofit/screens/home_screen.dart';
import 'package:todo_bloc_retrofit/screens/no_route_found.dart';

class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.homeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case RouteName.addAndUpdateTodoScreen:
        final args = settings.arguments as Map;

        return MaterialPageRoute(
          builder: (context) => AddAndUpdateTodoScreen(
            args: args,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const NoRouteFound(),
        );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:todo_bloc_retrofit/routes/route_name.dart';
import 'package:todo_bloc_retrofit/routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteName.homeScreen,
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}

import 'package:calendar_schedular/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  // runApp하기전에 initial을 먼저 하고 다른작업을 하겠다.
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  runApp(const MaterialApp(
    home: HomeScreen(),
  ));
}

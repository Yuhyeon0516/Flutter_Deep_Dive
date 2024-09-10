import 'package:calendar_schedular/database/drift.dart';
import 'package:calendar_schedular/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  // 기존에는 ensureInitialized가 runApp에서 실행되지만
  // runApp하기 전 다른 함수를 사용하고 싶다면 먼저 initial을 먼저 진행 후 다른 함수를 실행해야함.
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  final database = AppDatabase();

  GetIt.I.registerSingleton<AppDatabase>(database);

  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      home: const HomeScreen(),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:full_course/core/theme/app_theme.dart';
import 'package:full_course/features/auth/presentation/pages/signin_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "blog app",
      theme: AppTheme.darkThemeMode,
      debugShowCheckedModeBanner: false,
      home: const SigninPage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:full_course/core/theme/app_colors.dart';

class AppTheme {
  static _border(Color color) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundColor,
    ),
    chipTheme: const ChipThemeData(
      color: WidgetStatePropertyAll(AppColors.backgroundColor),
      side: BorderSide.none,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _border(AppColors.borderColor),
      focusedBorder: _border(AppColors.gradient2),
      errorBorder: _border(AppColors.errorColor),
      focusedErrorBorder: _border(AppColors.borderColor),
    ),
  );
}

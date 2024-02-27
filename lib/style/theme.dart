import 'package:flutter/material.dart';
import 'package:todo/style/app_color.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(size: 30),
        unselectedIconTheme: IconThemeData(size: 30)),
    scaffoldBackgroundColor: AppColor.scondryLight,
    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColor.primaryLight,
        primary: AppColor.primaryLight,
        onPrimary: AppColor.onprimaryLight),
    textTheme: const TextTheme(
      labelLarge: TextStyle(
          color: AppColor.onprimaryLight,
          fontSize: 22,
          fontWeight: FontWeight.w700),
      bodySmall: TextStyle(fontSize: 18, color: Color(0xff2B73A4)),
    ),
  );
}

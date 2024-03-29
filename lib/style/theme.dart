import 'package:flutter/material.dart';
import 'package:todo/style/app_color.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(size: 30),
        unselectedIconTheme: IconThemeData(size: 30)),
    scaffoldBackgroundColor: AppColor.scondryLight,
    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColor.primaryLight,
        primary: AppColor.primaryLight,
        secondary: AppColor.scondryLight,
        onPrimary: AppColor.onprimaryLight,
        onSecondary: AppColor.onscondryLight,
        outline: AppColor.done),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
                      color: AppColor.onscondryLight,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                      bodyLarge: TextStyle(
                      color: AppColor.primaryLight,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
        labelLarge: TextStyle(
            color: AppColor.onprimaryLight,
            fontSize: 22,
            fontWeight: FontWeight.w700),
        bodySmall: TextStyle(fontSize: 18, color: Color(0xff2B73A4)),
        displayLarge: TextStyle(
            color: AppColor.primaryLight,
            fontSize: 15,
            fontWeight: FontWeight.w700),
        displaySmall: TextStyle(
            color: AppColor.onprimaryLight,
            fontSize: 15,
            fontWeight: FontWeight.w700),
        displayMedium: TextStyle(
            color: AppColor.onscondryLight,
            fontWeight: FontWeight.w700,
            fontSize: 15),
            labelMedium: TextStyle(
                  color: AppColor.onscondryLight,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),),
  );
}

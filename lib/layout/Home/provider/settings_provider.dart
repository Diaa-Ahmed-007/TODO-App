import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  String currentTheme = 'Light';
  ThemeMode getThemeMode() {
    if (currentTheme == "Light") {
      return ThemeMode.light;
    } else if (currentTheme == 'Dark') {
      return ThemeMode.dark;
    }
    return ThemeMode.light;
  }

  changeTheme(String theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentTheme = theme;
    await prefs.setString('theme', theme);
    notifyListeners();
  }

  initializeTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentTheme = prefs.getString('theme') ?? 'Light';
    notifyListeners();
  }

//------------------------------------------------------------------------------

  // String selectedLanguage = 'English';
  // changeSelectedLanguage(String newValue) {
  //   if (selectedLanguage == newValue) return;
  //   selectedLanguage = newValue;
  //   notifyListeners();
  // }

  String selectedLanguage = 'en';
  String getLanguage() {
    if (selectedLanguage == 'ar') {
      return 'ar';
    } else {
      return 'en';
    }
  }

  changeSelectedLanguage(String newLanguage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedLanguage = newLanguage;
    await prefs.setString('newLanguage', newLanguage);
    notifyListeners();
  }

  initializeLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedLanguage = prefs.getString('newLanguage') ?? 'en';
    notifyListeners();
  }
}

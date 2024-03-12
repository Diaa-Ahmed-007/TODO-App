import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  int currentNavIndex = 0;
  void changeTab(int newIndex) {
    if (currentNavIndex == newIndex) return;
    currentNavIndex = newIndex;
    notifyListeners();
  }

  bool isBottomSheetOpened = false;
  void changeBootomSheetValue() {
    isBottomSheetOpened = !isBottomSheetOpened;
    notifyListeners();
  }

  DateTime? selectedDate = DateTime.now();

  void selectNewDate(DateTime? newSelected) {
    if (selectedDate == newSelected) return;
    selectedDate = newSelected;
    notifyListeners();
  }

  TimeOfDay? selectedTime = TimeOfDay.now();
  void selectNewTime(TimeOfDay? newSelected) {
    if (selectedTime == newSelected) return;
    selectedTime = newSelected;
    notifyListeners();

  }
      bool visableFloatingActionButton = true;
    bool changeFloatingActionButtonVisable(bool newVal) {
      if (visableFloatingActionButton == newVal) {
        return visableFloatingActionButton;
      }
      visableFloatingActionButton = newVal;
      return visableFloatingActionButton;
    }
}

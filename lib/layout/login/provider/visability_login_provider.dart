import 'package:flutter/material.dart';

class VisabilityLoginProvider extends ChangeNotifier {
  bool passwordVisible = true;
  bool getLoginPassVisible() {
    if (passwordVisible == true) {
      return true;
    } else {
      return false;
    }
  }

  void changeVisible(bool isVisible) {
    passwordVisible = isVisible;
    notifyListeners();
  }
//------------------------------------------------------------
   bool _passwordVisible = true;
 
  bool getRegisterPassVisible() {
    if (_passwordVisible == true) {
      return true;
    } else {
      return false;
    }
  }
  void changeRegisterVisible(bool isVisible) {
    _passwordVisible = isVisible;
    notifyListeners();
  }
  //-------------------------------------------------------
    bool _passwordCheakedVisible = true;
  bool getPasswordCheakedVisible(){
    if (_passwordCheakedVisible== true) {
      return true;
    } else {
      return false;
    }
  }
  void changePasswordCheakedVisible(bool isVisible) {
    _passwordCheakedVisible = isVisible;
    notifyListeners();
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:todo/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  User? fireBaseUserAuth;
  UserModel? dataBaseUser;
  void setUsers(User? newFireBaseUserAuth,UserModel? newDataBaseUser){
    
  }
}

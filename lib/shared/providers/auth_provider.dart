import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:todo/models/user_model.dart';
import 'package:todo/shared/remote/firebase/firestore_helper.dart';

class MyAuthProvider extends ChangeNotifier {
  User? fireBaseUserAuth;
  UserModel?dataBaseUser;
  void setUsers(User? newFireBaseUserAuth, UserModel? newDataBaseUser) {
    fireBaseUserAuth = newFireBaseUserAuth;
    dataBaseUser = newDataBaseUser;
  }

  bool isFirebaseUserLoggedIn() {
    if (FirebaseAuth.instance.currentUser == null) return false;
    fireBaseUserAuth = FirebaseAuth.instance.currentUser;
    return true;
  }

  Future<void> retrieveDatabaseUserData() async {
    try {
      dataBaseUser =
          await FirestoreHelper.getUser(UserID: fireBaseUserAuth!.uid);
          
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> signOut() async {
    fireBaseUserAuth = null;
    dataBaseUser = null;
    return await FirebaseAuth.instance.signOut();
  }
}

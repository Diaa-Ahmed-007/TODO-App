import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? userID;
  String? email;
  String? fullName;
  UserModel(
      {required this.userID, required this.email, required this.fullName});
  factory UserModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot, option) {
    Map<String, dynamic>? data = snapshot.data();
    return UserModel(
        userID: data!['id'], email: data['email'], fullName: data['name']);
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (userID != null) "id": userID,
      if (email != null) "email": email,
      if (fullName != null) "name": fullName
    };
  }
}

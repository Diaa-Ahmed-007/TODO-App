import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? userID;
  String? fullName;
  String? email;
  UserModel(
      {required this.userID, required this.email, required this.fullName});
  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
        userID: data?['id'], email: data?['email'], fullName: data?['name']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      // if ( != null) "name": name,
      if (userID != null) "id": userID,
      if(email!=null) "email":email,
if(fullName!=null)"name":fullName,
    };
  }
}

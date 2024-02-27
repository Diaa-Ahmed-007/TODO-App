import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/models/user_model.dart';

class FirestoreHelper {
  CollectionReference<UserModel> getUserCollection() {
    var reference = FirebaseFirestore.instance.collection("User").withConverter(
      fromFirestore: (snapshot, options) {
        return UserModel.fromFirestore(snapshot, options);
      },
      toFirestore: (user, options) {
        return user.toFirestore();
      },
    );
    return reference;
  }

  addUser(
      {required String userId,
      required String email,
      required String fullName}) async {
    var document = getUserCollection().doc(userId);
    await document
        .set(UserModel(userID: userId, email: email, fullName: fullName));
  }

  Future<UserModel?> getUser({required String UserID}) async {
    var document = getUserCollection().doc(UserID);
    var snapshot = await document.get();
    UserModel? userData = snapshot.data();
    return userData;
  }
}

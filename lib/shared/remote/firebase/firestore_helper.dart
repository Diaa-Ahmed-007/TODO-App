import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/models/user_model.dart';

class FirestoreHelper {
  static CollectionReference<UserModel> getUserCollection() {
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

  static Future<void> addUser(
      {required String userId,
      required String email,
      required String fullName}) async {
    var document = getUserCollection().doc(userId);
    await document
        .set(UserModel(userID: userId, email: email, fullName: fullName));
  }

  static Future<UserModel?> getUser({required String UserID}) async {
    var document = getUserCollection().doc(UserID);
    var snapshot = await document.get();
    UserModel? userData = snapshot.data();
    return userData;
  }

  static CollectionReference<TaskModel> getTaskCollection(String userID) {
    var tasksCollection =
        getUserCollection().doc(userID).collection("Tasks").withConverter(
      fromFirestore: (snapshot, options) {
        return TaskModel.fromFirestore(snapshot.data() ?? {});
      },
      toFirestore: (value, options) {
        return value.toFirestore();
      },
    );
    return tasksCollection;
  }

  static Future<void> addNewTask(
      {required TaskModel task, required String userID}) async {
    var document = getTaskCollection(userID).doc();
    task.id = document.id;
    await document.set(task);
  }

  // static Future<List<TaskModel>> getTasks({required String UserID}) async {
  //   var document = await getTaskCollection(UserID).get();
  //   List<TaskModel> tasks =
  //       document.docs.map((snapshot) => snapshot.data()).toList();
  //   return tasks;
  // }
  static Future<String> getTimeDoc(
      {required String userID, required String taskID}) async {
    var time = await getTaskCollection(userID).doc(taskID).get();
    return time["time"];
  }

  static Stream<List<TaskModel>> listenToTasks(
      {required String UserID, required int date}) async* {
    Stream<QuerySnapshot<TaskModel>> taskStream =
        getTaskCollection(UserID).where("date", isEqualTo: date).snapshots();
    Stream<List<TaskModel>> tasks = taskStream
        .map((event) => event.docs.map((snapshot) => snapshot.data()).toList());
    yield* tasks;
  }

  static Future<void> deleteTask(
      {required String userID, required String taskID}) async {
    await getTaskCollection(userID).doc(taskID).delete();
  }

  static Future<void> updateTasks(
      {required String userID,
      required String taskID,
      required TaskModel task}) async {
    await getTaskCollection(userID).doc(taskID).update(task.toFirestore());
  }
  static Stream<List<TaskModel>> historyTask({required String UserID, required int date})async*{
    Stream<QuerySnapshot<TaskModel>> taskStream =
        getTaskCollection(UserID).where("date", isLessThan: date).orderBy('date',descending: true).snapshots();
    Stream<List<TaskModel>> tasks = taskStream
        .map((event) => event.docs.map((snapshot) => snapshot.data()).toList());
    yield* tasks;
  }

  static Future<void> getIsDoneValue(
      {required String userID,
      required String taskID,
      required bool newValue}) async {
    await getTaskCollection(userID).doc(taskID).update({"isDone": newValue});
  }
}

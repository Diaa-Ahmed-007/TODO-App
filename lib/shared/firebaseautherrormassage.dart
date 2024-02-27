import 'package:flutter/material.dart';

class FireBaseAuthErrorMassage{
   static void showSnackBar(BuildContext context, String massage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: const Duration(seconds: 2),
          content: Center(
            child: Text(
              massage,
              style: const TextStyle(color: Colors.white),
            ),
          )),
    );
  }
}
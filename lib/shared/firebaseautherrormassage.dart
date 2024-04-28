import 'package:flutter/material.dart';

class FireBaseAuthErrorMassage {
  static void alertDialog(BuildContext context, String massage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(massage),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black26),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("try again"),
            ),
          ],
        );
      },
    );
  }
}

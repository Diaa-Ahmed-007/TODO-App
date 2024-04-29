import 'package:flutter/material.dart';

class FireBaseAuthErrorMassage {
  static void successAlertDialog(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        return showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: Text("success"),
            );
          },
        );
      },
    );
  }

  static void loadingAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

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

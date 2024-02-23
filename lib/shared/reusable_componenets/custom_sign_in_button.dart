import 'package:flutter/material.dart';

class CustomSignInButton extends StatelessWidget {
  const CustomSignInButton({super.key, required this.ontap, required this.lapel});
  final Function() ontap;
  final String lapel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: FilledButton(
        onPressed: ontap,
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.blue),
          minimumSize: MaterialStatePropertyAll(
            Size(double.infinity, 50),
          ),
        ),
        child:  Text(
          lapel,
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
      ),
    );
  }
}

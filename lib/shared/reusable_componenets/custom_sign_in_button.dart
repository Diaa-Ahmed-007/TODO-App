import 'package:flutter/material.dart';

class CustomSignInButton extends StatelessWidget {
  const CustomSignInButton(
      {super.key, required this.ontap, required this.lapel});
  final Function() ontap;
  final String lapel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              Color(0xffF5591F),
              Color(0xffF56A1F),
              Color(0xffF5781F),
              Color(0xffF5811F),
              Color(0xffF5891F),
            ],
          ),
        ),
        height: 50,
        width: double.infinity,
        child: FilledButton(
          onPressed: ontap,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
          ),
          child: Text(
            lapel,
            style: const TextStyle(fontSize: 22, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

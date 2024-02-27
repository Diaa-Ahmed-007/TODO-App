import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.labelWord,
    super.key,
    required this.controller,
    required this.val, this.iconbuttoneye, required this.passwordVisible,
  });
  final String labelWord;
  final TextEditingController controller;
  final String? Function(String?) val;
  final Widget? iconbuttoneye;
  final bool passwordVisible;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextFormField(
        validator: val,
        controller: controller,
        cursorColor: Colors.black,
        style: const TextStyle(color: Colors.black),
        obscureText: passwordVisible,
        decoration: InputDecoration(
            suffixIcon: iconbuttoneye,
            
            hintText: labelWord,
        
            hintStyle: const TextStyle(color: Color(0xff2B73A4)),
            hintMaxLines: 1,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Color(0xff3598DB),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                  color: Color(0xff3598DB), style: BorderStyle.solid),
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.red)),
            errorStyle: const TextStyle(color: Colors.red),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.red)),
            fillColor: Colors.white,
            filled: true),
      ),
    );
  }
}

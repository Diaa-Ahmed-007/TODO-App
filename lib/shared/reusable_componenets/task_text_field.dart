import 'package:flutter/material.dart';

class TaskTextField extends StatelessWidget {
  const TaskTextField(
      {super.key,
      required this.controller,
      required this.val,
      required this.label});
  final TextEditingController controller;
  final String? Function(String?) val;
  final String label;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: val,
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(),
        hintText: label,
      ),
    );
  }
}

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
      style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 16),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.onSecondary),
        ),
        hintText: label,
        hintStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
      ),
    );
  }
}

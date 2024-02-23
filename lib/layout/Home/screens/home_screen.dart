import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = "HomeScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: 170,
        title: Text(
          'To Do List',
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
      body: const Column(
        children: [
        ],
      ),
    );
  }
}

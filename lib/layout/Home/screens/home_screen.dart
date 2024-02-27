import 'package:flutter/material.dart';
import 'package:todo/models/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final UserModel user =
        ModalRoute.of(context)!.settings.arguments as UserModel;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: 170,
        title: Text(
          'Hello ${user.fullName ?? 'user'}',
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
      body: const Column(
        children: [],
      ),
      bottomNavigationBar: BottomNavigationBar(
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Notes List",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: "settings",
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.all(16),
        height: 64,
        width: 64,
        child: FloatingActionButton(
          onPressed: () {},
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 3, color: Theme.of(context).colorScheme.onPrimary),
              borderRadius: BorderRadius.circular(100)),
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}

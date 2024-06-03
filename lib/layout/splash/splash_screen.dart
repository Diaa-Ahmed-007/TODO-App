// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/layout/Home/screens/home_screen.dart';
import 'package:todo/layout/login/screen/login_screen.dart';
import 'package:todo/shared/providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = 'splash';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(
      const Duration(seconds: 2),
      () {
        checkAutoLogin();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
              child: Image.asset(
            'assets/images/logo.png',
            color: Theme.of(context).colorScheme.primary,
          )),
          const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 90,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> checkAutoLogin() async {
    MyAuthProvider provider =
        Provider.of<MyAuthProvider>(context, listen: false);
    if (provider.isFirebaseUserLoggedIn()) {
      await provider.retrieveDatabaseUserData();
      Navigator.pushReplacementNamed(context, HomeScreen.routeName,
          arguments: provider.dataBaseUser);
    } else {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
  }
}

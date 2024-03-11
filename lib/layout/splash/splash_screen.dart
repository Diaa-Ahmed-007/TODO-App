// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/layout/Home/screens/home_screen.dart';
import 'package:todo/layout/login/login_screen.dart';
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
    await Future.delayed(const Duration(seconds: 2), () {
      checkAutoLogin();
      //   Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(
            flex: 2,
          ),
          Center(child: Image.asset('assets/images/logo.png')),
          const Spacer(),
          Image.asset('assets/images/route blue.png'),
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

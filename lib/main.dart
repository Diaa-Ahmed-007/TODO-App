import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/layout/Home/screens/home_screen.dart';
import 'package:todo/layout/login/login_screen.dart';
import 'package:todo/layout/login/provider/visability_login_provider.dart';
import 'package:todo/layout/register/register_screen.dart';
import 'package:todo/layout/splash/splash_screen.dart';
import 'package:todo/style/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VisabilityPasswordProvider>(
      create: (BuildContext context) => VisabilityPasswordProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          RegisterScreen.routeName: (context) => const RegisterScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
        },
        theme: AppTheme.lightTheme,
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}

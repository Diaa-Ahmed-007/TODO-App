import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/layout/Home/provider/home_provider.dart';
import 'package:todo/layout/Home/provider/settings_provider.dart';
import 'package:todo/layout/Home/screens/home_screen.dart';
import 'package:todo/layout/Home/widgets/edit_task.dart';
import 'package:todo/layout/login/provider/visability_login_provider.dart';
import 'package:todo/layout/login/screen/login_screen.dart';
import 'package:todo/layout/register/register_screen.dart';
import 'package:todo/layout/splash/splash_screen.dart';
import 'package:todo/shared/providers/auth_provider.dart';
import 'package:todo/style/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<MyAuthProvider>(
        create: (context) => MyAuthProvider()),
    ChangeNotifierProvider<SettingsProvider>(
        create: (context) => SettingsProvider()
          ..initializeTheme()
          ..initializeLanguage()),
    ChangeNotifierProvider<VisabilityPasswordProvider>(
      create: (context) => VisabilityPasswordProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SettingsProvider provider = Provider.of<SettingsProvider>(context);
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('ar'), // Spanish
      ],
      locale: Locale(provider.getLanguage()),
      debugShowCheckedModeBanner: false,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        LoginScreen.routeName: (context) =>
            ChangeNotifierProvider<VisabilityPasswordProvider>(
                create: (BuildContext context) => VisabilityPasswordProvider(),
                child: LoginScreen()),
        RegisterScreen.routeName: (context) =>
            ChangeNotifierProvider<VisabilityPasswordProvider>(
                create: (BuildContext context) => VisabilityPasswordProvider(),
                child: const RegisterScreen()),
        HomeScreen.routeName: (context) => ChangeNotifierProvider(
              create: (context) => HomeProvider(),
              child: HomeScreen(),
            ),
        EditTask.routeName: (context) => ChangeNotifierProvider(
              create: (context) => HomeProvider(),
              child: EditTask(),
            ),
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.datkTheme,
      themeMode: provider.getThemeMode(),
      initialRoute: SplashScreen.routeName,
    );
  }
}

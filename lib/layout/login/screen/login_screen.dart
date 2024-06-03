import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/layout/Home/provider/settings_provider.dart';
import 'package:todo/layout/Home/screens/home_screen.dart';
import 'package:todo/layout/login/provider/visability_login_provider.dart';
import 'package:todo/layout/register/register_screen.dart';
import 'package:todo/models/user_model.dart';
import 'package:todo/shared/constants.dart';
import 'package:todo/shared/firebaseautherrormassage.dart';
import 'package:todo/shared/providers/auth_provider.dart';
import 'package:todo/shared/remote/firebase/firestore_helper.dart';
import 'package:todo/shared/reusable_componenets/custom_Text_Field.dart';
import 'package:todo/shared/reusable_componenets/custom_sign_in_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = 'loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final TextEditingController emailController = TextEditingController();

final TextEditingController passController = TextEditingController();

final formstate = GlobalKey<FormState>();

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    VisabilityPasswordProvider provider =
        Provider.of<VisabilityPasswordProvider>(context);
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    var hight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: formstate,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: hight * 0.4,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xffF5591F),
                    Color(0xffF56A1F),
                    Color(0xffF5781F),
                    Color(0xffF5811F),
                    Color(0xffF5891F),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                      settingsProvider.getLanguage() == 'en' ? 150 : 0),
                  bottomRight: Radius.circular(
                      settingsProvider.getLanguage() == 'en' ? 0 : 150),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Image.asset("assets/images/logo1.png")),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: settingsProvider.getLanguage() == 'en' ? 30 : 0,
                        left: settingsProvider.getLanguage() == 'en' ? 0 : 30,
                        top: 16),
                    child: Text(
                      AppLocalizations.of(context)!.login,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: hight * 0.15,
            ),
            CustomTextField(
              labelWord: AppLocalizations.of(context)!.email,
              val: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)?.fieldRequired ?? "";
                }
                if (!RegExp(Constants.regExp).hasMatch(value)) {
                  return AppLocalizations.of(context)?.invalidInput ?? "";
                }
                return null;
              },
              controller: emailController,
              passwordVisible: false,
              preIcon: "assets/images/round-email-24px.svg",
            ),
            CustomTextField(
              labelWord: AppLocalizations.of(context)!.password,
              val: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)?.fieldRequired ?? "";
                }
                return null;
              },
              controller: passController,
              passwordVisible: provider.passwordVisible,
              iconbuttoneye: IconButton(
                onPressed: () {
                  provider.changeVisible(
                      provider.getLoginPassVisible() ? false : true);
                },
                icon: VisabilityPasswordProvider().getLoginPassVisible()
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
              ),
              preIcon: "assets/images/round-vpn_key-24px.svg",
            ),
            CustomSignInButton(
              ontap: () {
                if (formstate.currentState!.validate()) {
                  logIn(context);
                }
              },
              lapel: AppLocalizations.of(context)!.login,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.haveNotAccount,
                  style: TextStyle(
                      color: settingsProvider.getThemeMode() == ThemeMode.light
                          ? Colors.black
                          : Colors.white),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegisterScreen.routeName);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.register,
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(fontSize: 18),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void logIn(BuildContext context) async {
    MyAuthProvider provider =
        Provider.of<MyAuthProvider>(context, listen: false);
    FireBaseAuthErrorMassage.loadingAlertDialog(context);
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passController.text);
      UserModel? user =
          await FirestoreHelper.getUser(UserID: credential.user!.uid);
      provider.setUsers(credential.user, user);
      Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(
        context,
        HomeScreen.routeName,
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Navigator.pop(context);
        FireBaseAuthErrorMassage.alertDialog(
            context, AppLocalizations.of(context)?.noUser ?? "");
      } else if (e.code == 'wrong-password') {
        Navigator.pop(context);
        FireBaseAuthErrorMassage.alertDialog(
            context, AppLocalizations.of(context)?.wrongePass ?? "");
      }
    } catch (e) {
      Navigator.pop(context);
      FireBaseAuthErrorMassage.alertDialog(context, e.toString());
    }
  }
}

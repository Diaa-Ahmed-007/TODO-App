import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/layout/Home/provider/settings_provider.dart';
import 'package:todo/layout/Home/screens/home_screen.dart';
import 'package:todo/layout/login/provider/visability_login_provider.dart';
import 'package:todo/models/user_model.dart';
import 'package:todo/shared/constants.dart';
import 'package:todo/shared/firebaseautherrormassage.dart';
import 'package:todo/shared/providers/auth_provider.dart';
import 'package:todo/shared/remote/firebase/firestore_helper.dart';
import 'package:todo/shared/reusable_componenets/custom_Text_Field.dart';
import 'package:todo/shared/reusable_componenets/custom_sign_in_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const routeName = 'registerScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

final formState = GlobalKey<FormState>();
final TextEditingController fullName = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passController = TextEditingController();
final TextEditingController confirmPassController = TextEditingController();

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    VisabilityPasswordProvider provider =
        Provider.of<VisabilityPasswordProvider>(context);
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Form(
          key: formState,
          child: Column(
            children: [
              Container(
                height: height * 0.4,
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
                          right:
                              settingsProvider.getLanguage() == 'en' ? 30 : 0,
                          left: settingsProvider.getLanguage() == 'en' ? 0 : 30,
                          top: 16),
                      child: Text(
                        AppLocalizations.of(context)!.register,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
              CustomTextField(
                labelWord: AppLocalizations.of(context)!.name,
                controller: fullName,
                val: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)?.fieldRequired ?? "";
                  }
                  return null;
                },
                passwordVisible: false,
                preIcon: "assets/images/round-person-24px.svg",
              ),
              CustomTextField(
                preIcon: "assets/images/round-email-24px.svg",
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
              ),
              CustomTextField(
                preIcon: "assets/images/round-vpn_key-24px.svg",
                iconbuttoneye: IconButton(
                  onPressed: () {
                    provider.changeRegisterVisible(
                        provider.getRegisterPassVisible() ? false : true);
                  },
                  icon: provider.getRegisterPassVisible()
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                ),
                labelWord: AppLocalizations.of(context)!.password,
                val: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)?.fieldRequired ?? "";
                  }
                  if (value.length < 8) {
                    return AppLocalizations.of(context)?.passLength ?? "";
                  }
                  return null;
                },
                controller: passController,
                passwordVisible: provider.getRegisterPassVisible(),
              ),
              CustomTextField(
                labelWord: AppLocalizations.of(context)!.confirmPass,
                controller: confirmPassController,
                val: (value) {
                  if (value != passController.text) {
                    return AppLocalizations.of(context)?.notMatch ?? "";
                  }
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)?.fieldRequired ?? "";
                  }
                  return null;
                },
                passwordVisible: provider.getPasswordCheakedVisible(),
                iconbuttoneye: IconButton(
                    onPressed: () {
                      provider.changePasswordCheakedVisible(
                          provider.getPasswordCheakedVisible() ? false : true);
                    },
                    icon: provider.getPasswordCheakedVisible()
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility)),
                preIcon: "assets/images/round-vpn_key-24px.svg",
              ),
              CustomSignInButton(
                ontap: () async {
                  await newRegister(
                      context: context,
                      emailController: emailController,
                      passController: passController,
                      fullName: fullName,
                      formState: formState);
                },
                lapel: AppLocalizations.of(context)!.register,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.haveAccount,
                    style: const TextStyle(color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(AppLocalizations.of(context)!.login,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(fontSize: 18)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> newRegister(
      {required BuildContext context,
      required TextEditingController emailController,
      required TextEditingController passController,
      required GlobalKey<FormState> formState,
      required TextEditingController fullName}) async {
    MyAuthProvider provider =
        Provider.of<MyAuthProvider>(context, listen: false);
    if (formState.currentState!.validate()) {
      FireBaseAuthErrorMassage.loadingAlertDialog(context);
      try {
        var user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passController.text);
        await FirestoreHelper.addUser(
            userId: user.user!.uid,
            email: emailController.text,
            fullName: fullName.text);
        provider.setUsers(
            user.user,
            UserModel(
                userID: user.user!.uid,
                email: emailController.text,
                fullName: fullName.text));

        Navigator.pop(context);
        FireBaseAuthErrorMassage.successAlertDialog(context);

        Navigator.pushNamedAndRemoveUntil(
          context,
          HomeScreen.routeName,
          (route) => false,
        );
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);

        if (e.code == 'email-already-in-use') {
          FireBaseAuthErrorMassage.alertDialog(
              context, AppLocalizations.of(context)?.emailAlreadyUse ?? "");
        } else {
          FireBaseAuthErrorMassage.alertDialog(context, e.code);
        }
      } catch (e) {
        Navigator.pop(context);
        FireBaseAuthErrorMassage.alertDialog(context, e.toString());
      }
    }
  }
}

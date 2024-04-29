import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/layout/Home/screens/home_screen.dart';
import 'package:todo/layout/login/provider/visability_login_provider.dart';
import 'package:todo/models/user_model.dart';
import 'package:todo/shared/constants.dart';
import 'package:todo/shared/firebaseautherrormassage.dart';
import 'package:todo/shared/providers/auth_provider.dart';
import 'package:todo/shared/remote/firebase/firestore_helper.dart';
import 'package:todo/shared/reusable_componenets/custom_Text_Field.dart';
import 'package:todo/shared/reusable_componenets/custom_sign_in_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  static const routeName = 'registerScreen';

  @override
  Widget build(BuildContext context) {
    final TextEditingController fullName = TextEditingController();

    final TextEditingController emailController = TextEditingController();

    final TextEditingController passController = TextEditingController();

    final TextEditingController confirmPassController = TextEditingController();

    final formstate = GlobalKey<FormState>();
    VisabilityPasswordProvider provider =
        Provider.of<VisabilityPasswordProvider>(context);
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/SIGN IN pg.jpg'),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: Text(
            AppLocalizations.of(context)!.register,
            style: const TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Form(
          key: formstate,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(
                height: 160,
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
              ),
              CustomTextField(
                labelWord: AppLocalizations.of(context)!.email,
                val: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)?.fieldRequired ?? "";
                  }
                  if (!RegExp(Constants.regExp).hasMatch(value)) {
                    return AppLocalizations.of(context)?.invalidInput??"";
                  }
                  return null;
                },
                controller: emailController,
                passwordVisible: false,
              ),
              CustomTextField(
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
                    return AppLocalizations.of(context)?.passLength??"";
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
                    return AppLocalizations.of(context)?.notMatch??"";
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
              ),
              CustomSignInButton(
                  ontap: () async {
                    await newRegister(
                        context: context,
                        emailController: emailController,
                        passController: passController,
                        fullName: fullName,
                        formstate: formstate);
                  },
                  lapel: AppLocalizations.of(context)!.register),
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
      {context, emailController, passController, formstate, fullName}) async {
    MyAuthProvider provider =
        Provider.of<MyAuthProvider>(context, listen: false);
    if (formstate.currentState!.validate()) {
      FireBaseAuthErrorMassage.loadingAlertDialog(context);
      try {
        Navigator.pop(context);
        FireBaseAuthErrorMassage.successAlertDialog(context);
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

        Navigator.pushNamedAndRemoveUntil(
          context,
          HomeScreen.routeName,
          (route) => false,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          Navigator.pop(context);

          FireBaseAuthErrorMassage.alertDialog(
              context, AppLocalizations.of(context)?.emailAlreadyUse ?? "");
        } else {
          Navigator.pop(context);

          FireBaseAuthErrorMassage.alertDialog(context, e.code);
        }
      } catch (e) {
        Navigator.pop(context);

        FireBaseAuthErrorMassage.alertDialog(context, e.toString());
      }
    }
  }
}

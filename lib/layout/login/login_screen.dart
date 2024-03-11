import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  static const routeName = 'loginScreen';

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passController = TextEditingController();

  final formstate = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Login',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Form(
          key: formstate,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                labelWord: 'Email',
                val: (value) {
                  if (value == null || value.isEmpty) {
                    return 'this field is required';
                  }
                  if (!RegExp(Constants.regExp).hasMatch(value)) {
                    return 'invalid input';
                  }
                  return null;
                },
                controller: emailController,
                passwordVisible: false,
              ),
              CustomTextField(
                labelWord: 'password',
                val: (value) {
                  if (value == null || value.isEmpty) {
                    return 'this field is required';
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
              ),
              CustomSignInButton(
                ontap: () {
                  if (formstate.currentState!.validate()) {
                    logIn(context);
                  }
                },
                lapel: 'Login',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "don't have an account?",
                    style: TextStyle(color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterScreen.routeName);
                    },
                    child: Text(
                      "Sign Up",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void logIn(BuildContext context) async {
    MyAuthProvider provider =
        Provider.of<MyAuthProvider>(context, listen: false);
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passController.text);
      UserModel? user =
          await FirestoreHelper.getUser(UserID: credential.user!.uid);
      provider.setUsers(credential.user, user);
      Navigator.pushNamedAndRemoveUntil(
        context,
        HomeScreen.routeName,
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        FireBaseAuthErrorMassage.showSnackBar(
            context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        FireBaseAuthErrorMassage.showSnackBar(
            context, 'Wrong password provided for that user.');
      }
    }
  }
}

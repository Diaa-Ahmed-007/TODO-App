import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/shared/constants.dart';
import 'package:todo/shared/reusable_componenets/custom_Text_Field.dart';
import 'package:todo/shared/reusable_componenets/custom_sign_in_button.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  static const routeName = 'registerScreen';
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final formstate = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
          iconTheme: const IconThemeData(color: Colors.white),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Register',
            style: TextStyle(color: Colors.white),
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
                labelWord: 'First Name',
                controller: firstName,
                val: (value) {
                  if (value == null || value.isEmpty) {
                    return 'this field is required';
                  }
                  return null;
                },
              ),
              CustomTextField(
                labelWord: 'last Name',
                controller: lastName,
                val: (value) {
                  if (value == null || value.isEmpty) {
                    return 'this field is required';
                  }
                  return null;
                },
              ),
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
              ),
              CustomTextField(
                labelWord: 'password',
                val: (value) {
                  if (value == null || value.isEmpty) {
                    return 'this field is required';
                  }
                  if (value.length < 8) {
                    return "password can't be less than 8";
                  }
                  return null;
                },
                controller: passController,
              ),
              CustomTextField(
                labelWord: 'confirm passworsd',
                controller: confirmPassController,
                val: (value) {
                  if (value != passController.text) {
                    return 'not match';
                  }
                  if (value == null || value.isEmpty) {
                    return 'this field is required';
                  }
                  return null;
                },
              ),
              CustomSignInButton(
                  ontap: () async {
                    if (formstate.currentState!.validate()) {
                      try {
                        await registerUser(emailController, passController);
                        Navigator.pop(context);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'email-already-in-use') {
                          showSnackBar(context, 'email already exist');
                        } else {
                          showSnackBar(context, e.code);
                        }
                      }
                      showSnackBar(context, 'success');
                    }
                  },
                  lapel: 'Register'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "already have an account?",
                    style: TextStyle(color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Sign In",
                        style: Theme.of(context).textTheme.bodySmall),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, String massage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: const Duration(seconds: 2),
          content: Center(
            child: Text(
              massage,
              style: const TextStyle(color: Colors.white),
            ),
          )),
    );
  }

  Future registerUser(TextEditingController emailController,
      TextEditingController passController) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text, password: passController.text);
  }
}

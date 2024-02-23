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
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          title: const Text(
            'Register',
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
                  ontap: () {
                    if (formstate.currentState!.validate()) {
                      String name = emailController.text.trim();
                      String phone = passController.text.trim();
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
                    child: const Text(
                      "Sign In",
                      style: TextStyle(color: Color(0xff2B73A4)),
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
}

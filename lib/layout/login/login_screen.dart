import 'package:flutter/material.dart';
import 'package:todo/layout/register/register_screen.dart';
import 'package:todo/shared/constants.dart';
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
             
              CustomSignInButton(ontap: () {
                  if (formstate.currentState!.validate()) {
                    String name = emailController.text.trim();
                    String phone = passController.text.trim();
                  }
              }, lapel: 'Login',),
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
                    child: const Text(
                      "Sign Up",
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

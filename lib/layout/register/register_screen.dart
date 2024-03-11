import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
                controller: fullName,
                val: (value) {
                  if (value == null || value.isEmpty) {
                    return 'this field is required';
                  }
                  return null;
                },
                passwordVisible: false,
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
                passwordVisible: provider.getRegisterPassVisible(),
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

  Future<void> newRegister(
      {context, emailController, passController, formstate, fullName}) async {
    MyAuthProvider provider =
        Provider.of<MyAuthProvider>(context, listen: false);
    if (formstate.currentState!.validate()) {
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
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomeScreen.routeName,
          (route) => false,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          FireBaseAuthErrorMassage.showSnackBar(context, 'email already exist');
        } else {
          FireBaseAuthErrorMassage.showSnackBar(context, e.code);
        }
      }
      FireBaseAuthErrorMassage.showSnackBar(context, 'success');
    }
  }
}

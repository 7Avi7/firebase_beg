import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_beg/uihelper.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();

  forgotPassword(String email) async {
    if (email == '') {
      return UiHelper.CustomAlertBox(context, "Enter email to reset password ");
    } else {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        centerTitle: true,
        title: const Text('Forgot Password'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextField(
            emailController,
            "Please Enter your Email",
            "Email",
            Icons.email,
            false,
          ),
          const SizedBox(
            height: 20,
          ),
          UiHelper.CustomButton(() {
            forgotPassword(emailController.text.toString());
          }, "Reset Password"),
        ],
      ),
    );
  }
}

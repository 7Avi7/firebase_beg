import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_beg/loginpage.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';

class CheckUser extends StatefulWidget {
  const CheckUser({Key? key}) : super(key: key);

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void checkUser() async {
    print("Checking user...");
    final user = FirebaseAuth.instance.currentUser;
    print("User: $user");

    if (user != null) {
      navigateToHomePage();
    } else {
      navigateToLoginPage();
    }
  }

  void navigateToHomePage() {
    print("User is authenticated. Navigating to HomePage...");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  void navigateToLoginPage() {
    print("User is not authenticated. Navigating to LoginPage...");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
}

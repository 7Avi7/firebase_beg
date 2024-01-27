import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_beg/loginpage.dart';
import 'package:flutter/material.dart';

import 'fetch_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  logOut() async {
    FirebaseAuth.instance.signOut().then(
      (value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (contex) => const LoginPage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        centerTitle: true,
        title: const Text('Home Page'),
        actions: [
          ElevatedButton(
            onPressed: () {
              logOut();
            },
            child: const Text(
              'Log Out',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ),
        ],
      ),
      body: const FetchData(),
    );
  }
}

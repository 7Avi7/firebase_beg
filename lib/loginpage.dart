import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_beg/HomePage.dart';
import 'package:firebase_beg/passwordfield.dart';
import 'package:firebase_beg/phoneAuth.dart';
import 'package:firebase_beg/signUppage.dart';
import 'package:firebase_beg/uihelper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'forgotpassword.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool rememberMe = false;
  late SharedPreferences prefs;

  Future<void> saveRememberMePreference(bool value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool('rememberMe', value);
  }

  Future<bool> getRememberMePreference() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('rememberMe') ?? false;
  }

  @override
  void initState() {
    super.initState();
    getRememberMePreference().then((value) {
      setState(() {
        rememberMe = value;
        if (rememberMe) {
          // Retrieve and set saved email and password
          emailController.text = prefs.getString('savedEmail') ?? "";
          passwordController.text = prefs.getString('savedPassword') ?? "";
        }
      });
    });
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    // You can add more criteria as needed
    return null;
  }

  get isPasswordVisible => true;
  login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      UiHelper.CustomAlertBox(context, "Enter required fields");
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        // Save the "Remember Me" preference and credentials
        if (rememberMe) {
          saveRememberMePreference(true);
          prefs.setString('savedEmail', email);
          prefs.setString('savedPassword', password);
        } else {
          saveRememberMePreference(false);
          prefs.remove('savedEmail');
          prefs.remove('savedPassword');
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } on FirebaseAuthException catch (ex) {
        String errorMessage = 'Enter the Correct Email or Password.';

        switch (ex.code) {
          case 'user-not-found':
            errorMessage = 'No user found for that email.';
            break;
          case 'wrong-password':
            errorMessage = 'Wrong password provided for that user.';
            break;
          // Handle other FirebaseAuthException cases as needed

          default:
            break;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  // login(String email, String password) async {
  //   if (email == "" && password == "") {
  //     UiHelper.CustomAlertBox(context, "Enter required fields");
  //   } else {
  //     UserCredential? userCredential;
  //     try {
  //       userCredential = await FirebaseAuth.instance
  //           .signInWithEmailAndPassword(email: email, password: password);
  //
  //       // Save the "Remember Me" preference and credentials
  //       if (rememberMe) {
  //         saveRememberMePreference(true);
  //         prefs.setString('savedEmail', email);
  //         prefs.setString('savedPassword', password);
  //       } else {
  //         saveRememberMePreference(false);
  //         prefs.remove('savedEmail');
  //         prefs.remove('savedPassword');
  //       }
  //
  //       if (userCredential != null) {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => const HomePage(),
  //           ),
  //         );
  //       } else {
  //         // Handle unsuccessful login
  //       }
  //     } on FirebaseAuthException catch (ex) {
  //       return ex;
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    SharedPreferences prefs;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        centerTitle: true,
        title: const Text('Login Page'),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UiHelper.CustomTextField(
                emailController,
                "Please Enter your Email",
                "Email",
                Icons.email,
                false,
              ),
              UiHelperPassword(
                  controller: passwordController,
                  text: "Enter Password",
                  field: "Password"),
              // UiHelperPassword(
              //   validator: validatePassword,
              //   controller: passwordController,
              //   text: "Password",
              //   field: "Enter your Password",
              // ),
              CheckboxListTile(
                title: const Text(
                  'Remember my credentials after Logout',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                value: rememberMe,
                onChanged: (value) {
                  setState(() {
                    rememberMe = value!;
                  });
                },
              ),

              // Row(
              //   children: [
              //     const SizedBox(
              //       width: 15,
              //     ),
              //     Checkbox(
              //       // title: const Text("Remember "),
              //
              //       value: rememberMe,
              //       onChanged: (value) {
              //         setState(() {
              //           rememberMe = value!;
              //         });
              //       },
              //     ),
              //     const Flexible(
              //       child: Text(
              //         'Remember my credentials',
              //         style: TextStyle(
              //           color: Colors.grey,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(
                height: 30,
              ),
              UiHelper.CustomButton(() {
                login(emailController.text.toString(),
                    passwordController.text.toString());
              }, "Login"),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Check OTP ?',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PhoneAuth(),
                          ));
                    },
                    child: const Text(
                      'OTP Checking Page',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already Have an Account?',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ));
                    },
                    child: const Text(
                      'Sign Up',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPassword(),
                      ));
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

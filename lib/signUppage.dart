import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_beg/passwordfield.dart';
import 'package:firebase_beg/uihelper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'loginpage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  File? pickedImage;

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    // You can add more criteria as needed
    return null;
  }

  showAlertBoxImage() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Pick Image From"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
              ),
              ListTile(
                onTap: () {
                  pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.image),
                title: const Text('Gallery'),
              ),
            ],
          ),
        );
      },
    );
  }

  signUp(String email, String password) async {
    if (email == "" && password == "" && pickedImage == null) {
      UiHelper.CustomAlertBox(context, "Enter required fields");
    } else {
      UserCredential? userCredential;
      try {
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ));
          return null;
        });
        uploadDAta();
      } on FirebaseAuthException catch (ex) {
        return ex;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        centerTitle: true,
        title: const Text('Sign Up Page'),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  showAlertBoxImage();
                },
                child: pickedImage != null
                    ? CircleAvatar(
                        radius: 80,
                        backgroundImage: FileImage(pickedImage!),
                      )
                    : const CircleAvatar(
                        radius: 80,
                        child: Icon(
                          Icons.person,
                          size: 80,
                        ),
                      ),
              ),
              UiHelper.CustomTextField(
                emailController,
                "Please Enter your Email",
                "Email",
                Icons.email,
                false,
              ),
              UiHelperPassword(
                controller: passwordController,
                text: "Password",
                field: "Enter your Password",
                validator: validatePassword,
              ),
              const SizedBox(
                height: 30,
              ),
              UiHelper.CustomButton(() {
                signUp(
                  emailController.text.toString(),
                  passwordController.text.toString(),
                );
              }, "Sign Up"),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  pickImage(ImageSource imageSource) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageSource);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
      });
    } catch (ex) {
      print(ex.toString());
    }
  }

  uploadDAta() async {
    UploadTask uploadTask = FirebaseStorage.instance
        .ref("Profile Pics")
        .child(emailController.text.toString())
        .putFile(pickedImage!);

    TaskSnapshot taskSnapshot = await uploadTask;
    String url = await taskSnapshot.ref.getDownloadURL();
    FirebaseFirestore.instance
        .collection("Latest_User")
        .doc(emailController.text.toString())
        .set({
      "Email": emailController.text.toString(),
      "Image": url,
    }).then((value) {
      log("User Uploaded");
    });
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_beg/loginpage.dart';
// import 'package:firebase_beg/passwordfield.dart';
// import 'package:firebase_beg/uihelper.dart';
// import 'package:flutter/material.dart';
//
// class SignUpPage extends StatefulWidget {
//   const SignUpPage({super.key});
//
//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }
//
// class _SignUpPageState extends State<SignUpPage> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//
//   signUp(String email, String password) async {
//     if (email == "" && password == "") {
//       UiHelper.CustomAlertBox(context, "Enter required fields");
//     } else {
//       UserCredential? userCredential;
//       try {
//         userCredential = await FirebaseAuth.instance
//             .createUserWithEmailAndPassword(email: email, password: password)
//             .then((value) {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const LoginPage(),
//               ));
//         });
//       } on FirebaseAuthException catch (ex) {
//         return ex;
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.yellow,
//         centerTitle: true,
//         title: Text('Sign Up Page'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           UiHelper.CustomTextField(
//             emailController,
//             "Please Enter your Email",
//             "Email",
//             Icons.email,
//             false,
//           ),
//           UiHelperPassword(
//             controller: passwordController,
//             text: "Password",
//             field: "Enter your Password",
//           ),
//           const SizedBox(
//             height: 30,
//           ),
//           UiHelper.CustomButton(() {
//             signUp(
//               emailController.text.toString(),
//               passwordController.text.toString(),
//             );
//           }, "Sign Up"),
//           const SizedBox(
//             height: 20,
//           ),
//         ],
//       ),
//     );
//   }
// }

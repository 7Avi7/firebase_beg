import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'otpscreen.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  TextEditingController phoneController = TextEditingController();
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.phone),
                label: const Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Text(
                      'Phone Number',
                      // "Name",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                floatingLabelAlignment: FloatingLabelAlignment.center,
                // labelText: 'Name',
                alignLabelWithHint: true,
                hintText: "Please Enter Your Phone Number",
                hintStyle: const TextStyle(color: Colors.grey),
                // prefixIcon: const Icon(Icons.search),
                prefixIconColor: Colors.blueAccent,
                filled: true,
                fillColor: Colors.white10,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.green,
                    width: 4.5,
                    style: BorderStyle.solid,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 4.5,
                    style: BorderStyle.solid,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),

                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.indigoAccent,
                    width: 2.0,
                    style: BorderStyle.solid,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () async {
              FirebaseAuth.instance.verifyPhoneNumber(
                  verificationCompleted: (PhoneAuthCredential credential) {},
                  verificationFailed: (FirebaseAuthException ex) {},
                  codeSent: (String verificationid, int? resendtoken) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OTPScreen(
                          verificationid: verificationid,
                        ),
                      ),
                    );
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {},
                  phoneNumber: phoneController.text.toString());
            },
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.red,
              side: const BorderSide(
                color: Colors.yellow,
                width: 1,
              ),
              elevation: 4,
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue,

              // minimumSize: const Size(double.infinity, 10),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Text('Verify Phone Number and Send OTP'),
          ),
        ],
      ),
    );
  }
}

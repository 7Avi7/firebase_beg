import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_beg/uihelper.dart';
import 'package:flutter/material.dart';

import 'loginpage.dart';

class SendData extends StatefulWidget {
  const SendData({super.key});

  @override
  State<SendData> createState() => _SendDataState();
}

class _SendDataState extends State<SendData> {
  TextEditingController titleConltroller = TextEditingController();
  TextEditingController descriptionConltroller = TextEditingController();

  addData(String title, String description) {
    if (title == "" && description == "") {
      UiHelper.CustomAlertBox(context, "Enter required fields");
    } else {
      FirebaseFirestore.instance
          .collection("Sent_Data_From_User")
          .doc(title)
          .set({
        "Title": title,
        "Description": description,
      }).then((value) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25.0,
          ),
          child: TextFormField(
            controller: titleConltroller,
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.title),
              label: const Stack(
                alignment: Alignment.topCenter,
                children: [
                  Text(
                    "Title",
                    // "Name",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              floatingLabelAlignment: FloatingLabelAlignment.center,
              // labelText: 'Name',
              alignLabelWithHint: true,
              hintText: "Enter Title",
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
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25.0,
          ),
          child: TextFormField(
            controller: descriptionConltroller,
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.description),
              label: const Stack(
                alignment: Alignment.topCenter,
                children: [
                  Text(
                    "Description",
                    // "Name",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              floatingLabelAlignment: FloatingLabelAlignment.center,
              // labelText: 'Name',
              alignLabelWithHint: true,
              hintText: "Enter Description",
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
            addData(
              titleConltroller.text.toString(),
              descriptionConltroller.text.toString(),
            );
          },
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.red,
            side: const BorderSide(
              color: Colors.yellow,
            ),
            elevation: 4,
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,

            // minimumSize: const Size(double.infinity, 10),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: const Text('Send Data'),
        ),
      ],
    );
  }
}

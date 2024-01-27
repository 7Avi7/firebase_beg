import 'package:flutter/material.dart';

class UiHelper {
  static CustomTextField(
    TextEditingController controller,
    String text,
    String field,
    IconData iconData,
    bool toHide,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
      child: TextFormField(
        controller: controller,
        obscureText: toHide,
        decoration: InputDecoration(
          suffixIcon: Icon(iconData),
          label: Stack(
            alignment: Alignment.topCenter,
            children: [
              Text(
                field,
                // "Name",
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          floatingLabelAlignment: FloatingLabelAlignment.center,
          // labelText: 'Name',
          alignLabelWithHint: true,
          hintText: text,
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
    );
  }

  static CustomButton(VoidCallback voidCallback, String text) {
    return SizedBox(
      height: 50,
      width: 200,
      child: ElevatedButton(
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
        onPressed: () {
          voidCallback();
        },
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.green,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  static CustomAlertBox(BuildContext context, String text) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}

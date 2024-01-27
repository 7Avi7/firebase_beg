import 'package:flutter/material.dart';

class UiHelperPassword extends StatefulWidget {
  final TextEditingController controller;
  final String text;
  final String field;
  final String? Function(String?)? validator;

  const UiHelperPassword({
    Key? key,
    required this.controller,
    required this.text,
    required this.field,
    this.validator,
  }) : super(key: key);

  @override
  _UiHelperPasswordState createState() => _UiHelperPasswordState();
}

class _UiHelperPasswordState extends State<UiHelperPassword> {
  bool _obscureText = true;
  final GlobalKey<FormState> formKey = GlobalKey();
  void _submitForm() {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(formKey.currentContext!).showSnackBar(
        const SnackBar(content: Text('Submit Successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey, // Provide a key to the Form
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
        child: TextFormField(
          validator: widget.validator,
          controller: widget.controller,
          obscureText: _obscureText,
          onChanged: (value) {
            // Trigger the validation when the password changes
            Form.of(context).validate();
          },
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: _obscureText
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            label: Stack(
              alignment: Alignment.topCenter,
              children: [
                Text(
                  widget.field,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            floatingLabelAlignment: FloatingLabelAlignment.center,
            alignLabelWithHint: true,
            hintText: widget.text,
            hintStyle: const TextStyle(color: Colors.grey),
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
    );
  }
}

// import 'package:flutter/material.dart';
//
// class UiHelperPassword extends StatefulWidget {
//   final TextEditingController controller;
//   final String text;
//   final String field;
//   final String? Function(String?)? validator;
//
//   const UiHelperPassword({
//     Key? key,
//     required this.controller,
//     required this.text,
//     required this.field,
//     this.validator,
//   }) : super(key: key);
//
//   @override
//   _UiHelperPasswordState createState() => _UiHelperPasswordState();
// }
//
// class _UiHelperPasswordState extends State<UiHelperPassword> {
//   bool _obscureText = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
//       child: TextFormField(
//         validator: widget.validator,
//         controller: widget.controller,
//         obscureText: _obscureText,
//         decoration: InputDecoration(
//           suffixIcon: IconButton(
//             icon: _obscureText
//                 ? const Icon(Icons.visibility_off)
//                 : const Icon(Icons.visibility),
//             onPressed: () {
//               setState(() {
//                 _obscureText = !_obscureText;
//               });
//             },
//           ),
//           label: Stack(
//             alignment: Alignment.topCenter,
//             children: [
//               Text(
//                 widget.field,
//                 style: const TextStyle(color: Colors.grey),
//               ),
//             ],
//           ),
//           floatingLabelAlignment: FloatingLabelAlignment.center,
//           alignLabelWithHint: true,
//           hintText: widget.text,
//           hintStyle: const TextStyle(color: Colors.grey),
//           prefixIconColor: Colors.blueAccent,
//           filled: true,
//           fillColor: Colors.white10,
//           focusedBorder: OutlineInputBorder(
//             borderSide: const BorderSide(
//               color: Colors.green,
//               width: 4.5,
//               style: BorderStyle.solid,
//               strokeAlign: BorderSide.strokeAlignOutside,
//             ),
//             borderRadius: BorderRadius.circular(30),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderSide: const BorderSide(
//               color: Colors.red,
//               width: 4.5,
//               style: BorderStyle.solid,
//               strokeAlign: BorderSide.strokeAlignOutside,
//             ),
//             borderRadius: BorderRadius.circular(30),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderSide: const BorderSide(
//               color: Colors.indigoAccent,
//               width: 2.0,
//               style: BorderStyle.solid,
//               strokeAlign: BorderSide.strokeAlignOutside,
//             ),
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
//
// class UiHelperPassword extends StatefulWidget {
//   final TextEditingController controller;
//   final String text;
//   final String field;
//
//   const UiHelperPassword({
//     super.key,
//     required this.controller,
//     required this.text,
//     required this.field,
//     required String? Function(String? value) validator,
//   });
//
//   @override
//   _UiHelperPasswordState createState() => _UiHelperPasswordState();
// }
//
// class _UiHelperPasswordState extends State<UiHelperPassword> {
//   bool _obscureText = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
//       child: TextFormField(
//         validator: widget.validator,
//         controller: widget.controller,
//         obscureText: _obscureText,
//         decoration: InputDecoration(
//           suffixIcon: IconButton(
//             icon: _obscureText
//                 ? const Icon(Icons.visibility_off)
//                 : const Icon(Icons.visibility),
//             onPressed: () {
//               setState(() {
//                 _obscureText = !_obscureText;
//               });
//             },
//           ),
//           label: Stack(
//             alignment: Alignment.topCenter,
//             children: [
//               Text(
//                 widget.field,
//                 style: const TextStyle(color: Colors.grey),
//               ),
//             ],
//           ),
//           floatingLabelAlignment: FloatingLabelAlignment.center,
//           alignLabelWithHint: true,
//           hintText: widget.text,
//           hintStyle: const TextStyle(color: Colors.grey),
//           prefixIconColor: Colors.blueAccent,
//           filled: true,
//           fillColor: Colors.white10,
//           focusedBorder: OutlineInputBorder(
//             borderSide: const BorderSide(
//               color: Colors.green,
//               width: 4.5,
//               style: BorderStyle.solid,
//               strokeAlign: BorderSide.strokeAlignOutside,
//             ),
//             borderRadius: BorderRadius.circular(30),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderSide: const BorderSide(
//               color: Colors.red,
//               width: 4.5,
//               style: BorderStyle.solid,
//               strokeAlign: BorderSide.strokeAlignOutside,
//             ),
//             borderRadius: BorderRadius.circular(30),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderSide: const BorderSide(
//               color: Colors.indigoAccent,
//               width: 2.0,
//               style: BorderStyle.solid,
//               strokeAlign: BorderSide.strokeAlignOutside,
//             ),
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // import 'package:flutter/material.dart';
// //
// // class UiHelperPassword {
// //   static CustomTextField(
// //     TextEditingController controller,
// //     String text,
// //     String field,
// //     bool toHide,
// //   ) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
// //       child: TextFormField(
// //         controller: controller,
// //         obscureText: toHide,
// //         decoration: InputDecoration(
// //           suffixIcon: IconButton(
// //             icon: toHide ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
// //             onPressed: () {
// //               // Toggle the value of toHide when the IconButton is pressed
// //               // Update the obscureText property accordingly
// //               toHide = !toHide;
// //             },
// //           ),
// //           label: Stack(
// //             alignment: Alignment.topCenter,
// //             children: [
// //               Text(
// //                 field,
// //                 style: TextStyle(color: Colors.grey),
// //               ),
// //             ],
// //           ),
// //           floatingLabelAlignment: FloatingLabelAlignment.center,
// //           alignLabelWithHint: true,
// //           hintText: text,
// //           hintStyle: const TextStyle(color: Colors.grey),
// //           prefixIconColor: Colors.blueAccent,
// //           filled: true,
// //           fillColor: Colors.white10,
// //           focusedBorder: OutlineInputBorder(
// //             borderSide: const BorderSide(
// //               color: Colors.green,
// //               width: 4.5,
// //               style: BorderStyle.solid,
// //               strokeAlign: BorderSide.strokeAlignOutside,
// //             ),
// //             borderRadius: BorderRadius.circular(30),
// //           ),
// //           errorBorder: OutlineInputBorder(
// //             borderSide: const BorderSide(
// //               color: Colors.red,
// //               width: 4.5,
// //               style: BorderStyle.solid,
// //               strokeAlign: BorderSide.strokeAlignOutside,
// //             ),
// //             borderRadius: BorderRadius.circular(30),
// //           ),
// //           enabledBorder: OutlineInputBorder(
// //             borderSide: const BorderSide(
// //               color: Colors.indigoAccent,
// //               width: 2.0,
// //               style: BorderStyle.solid,
// //               strokeAlign: BorderSide.strokeAlignOutside,
// //             ),
// //             borderRadius: BorderRadius.circular(10),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

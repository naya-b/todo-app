import 'package:flutter/material.dart';

class TextFormFieldWidgetRegistertPage extends StatelessWidget {
  final bool showOrHide;
  final String hintText;
  final TextEditingController controller;
  const TextFormFieldWidgetRegistertPage(
      {required this.showOrHide,
      required this.hintText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: showOrHide,
      validator: (value) {
        print('value $value');
        if (hintText == 'Password') {
          print('now');
          print(hintText);
          value!.length < 8 ? 'Password must be at least 8 characters' : null;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }
}

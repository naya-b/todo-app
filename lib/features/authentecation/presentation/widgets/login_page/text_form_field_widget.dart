import 'package:flutter/material.dart';

class TextFormFieldWidgetLoginPage extends StatelessWidget {
  final bool showOrHide;
  final String hintText;
  final TextEditingController controller;
  const TextFormFieldWidgetLoginPage(
      {required this.showOrHide,
      required this.hintText,
      required this.controller});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: showOrHide,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade100,
        filled: true,
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

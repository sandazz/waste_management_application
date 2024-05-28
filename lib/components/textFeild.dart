import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide:
              BorderSide(color: Colors.green, width: 0.0),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(color: Colors.green, width: 2.0),
            ),
            border: const OutlineInputBorder(),
            labelText: hintText,
            labelStyle: TextStyle(color: Colors.green[700])),
      ),
    );
  }
}

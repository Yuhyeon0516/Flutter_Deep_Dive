import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
      ),
      obscureText: obscureText,
      validator: (value) {
        if (value!.trim().isEmpty) {
          return '$hintText 값을 입력해주세요.';
        }

        return null;
      },
    );
  }
}

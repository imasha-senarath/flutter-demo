import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Icon icon;
  final int? multiLine;

  const MyTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.obscureText,
    required this.icon,
    required this.multiLine,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        maxLines: multiLine,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          hintText: hintText,
          prefixIcon: icon,
        ),
      ),
    );
  }
}

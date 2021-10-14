import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String labelText;
  final TextInputType keyboardType;
  final bool isPassword;
  final Function(String)? onChanged;
  const MyTextField(
      {Key? key,
      required this.labelText,
      required this.keyboardType,
      required this.isPassword,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
            hintText: labelText,
            hintStyle: const TextStyle(fontSize: 20.0, color: Colors.white60),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.5),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
            )),
        keyboardType: keyboardType,
        obscureText: isPassword,
        onChanged: onChanged,
      ),
    );
  }
}

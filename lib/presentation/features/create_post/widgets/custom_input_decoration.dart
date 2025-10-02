import 'package:flutter/material.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';

class CustomInputDecoration {
  static InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      
      hintText: hint,
      hintStyle: const TextStyle(color: ColorConstants.hintColor),
      filled: true,
      fillColor: const Color.fromARGB(255, 215, 235, 255),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: const Color.fromARGB(84, 13, 35, 37)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: ColorConstants.primaryColor,
          width: 1.5,
        ),
      ),
    );
  }
}

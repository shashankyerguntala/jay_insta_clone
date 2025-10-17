import 'package:flutter/material.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/core%20/constants/string_constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String validatorMsg;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool isEmail;
  final bool isPassword;
  final bool isUsername;
  final bool isSignUp;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.validatorMsg,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.isEmail = false,
    this.isPassword = false,
    this.isUsername = false,
    this.isSignUp = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: ColorConstants.textSecondaryColor),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorConstants.errorColor),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorConstants.primaryColor),
          borderRadius: BorderRadius.circular(16),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color.fromARGB(145, 255, 255, 255),
          ),
        ),
        filled: true,
        fillColor: ColorConstants.fillColor,
        suffixIcon: suffixIcon,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorMsg;
        }

        if (isEmail && !RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
          return StringConstants.emailInvalid;
        }

        if (isPassword) {
          if (value.length < 6) {
            return StringConstants.passwordShort;
          }

          if (isSignUp) {
            final strongPasswordRegex = RegExp(
              r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%?&])[A-Za-z\d@$!%?&]+$',
            );
            if (!strongPasswordRegex.hasMatch(value)) {
              return StringConstants.passwordNotStrong;
            }
          }
        }

        if (isUsername && value.length < 4) {
          return StringConstants.usernameShort;
        }

        return null;
      },
    );
  }
}

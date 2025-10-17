import 'package:flutter/material.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/core%20/constants/string_constants.dart';
import 'package:jay_insta_clone/presentation/features/authentication/sign_in/widgets/custom_text_field.dart';

import 'package:jay_insta_clone/presentation/features/authentication/sign_up/screens/sign_up_screen.dart';

class SignInForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onPasswordVisibilityToggle;
  final VoidCallback onSubmit;
  final bool isLoading;

  const SignInForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.onPasswordVisibilityToggle,
    required this.onSubmit,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextField(
              controller: emailController,
              label: StringConstants.emailLabel,
              validatorMsg: StringConstants.emailEmpty,
              keyboardType: TextInputType.emailAddress,
              isEmail: true,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              controller: passwordController,
              label: StringConstants.passwordLabel,
              validatorMsg: StringConstants.passwordEmpty,
              obscureText: obscurePassword,
              isPassword: true,
              suffixIcon: IconButton(
                icon: Icon(
                  obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: ColorConstants.hintColor,
                ),
                onPressed: onPasswordVisibilityToggle,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              spacing: 4,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  StringConstants.notUser,
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  child: Text(
                    StringConstants.signUpTitle,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.primaryColor,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : onSubmit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: ColorConstants.primaryColor,
                ),
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: ColorConstants.fillColor,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        StringConstants.signInTitle,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: ColorConstants.fillColor,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

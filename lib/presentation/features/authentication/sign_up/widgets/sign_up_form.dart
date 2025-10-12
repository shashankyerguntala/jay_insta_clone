import 'package:flutter/material.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/core%20/constants/string_constants.dart';
import 'package:jay_insta_clone/presentation/features/authentication/sign_up/widgets/custom_text_field_sign_up.dart';

class SignUpForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;

  final VoidCallback onPasswordVisibilityToggle;

  final VoidCallback onSubmit;
  final bool isLoading;

  const SignUpForm({
    super.key,
    required this.formKey,
    required this.nameController,
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
            CustomTextFieldSignUp(
              controller: nameController,
              label: StringConstants.usernameLabel,
              validatorMsg: StringConstants.usernameEmpty,
            ),
            const SizedBox(height: 16),

            CustomTextFieldSignUp(
              controller: emailController,
              label: StringConstants.emailLabel,
              validatorMsg: StringConstants.emailEmpty,
              keyboardType: TextInputType.emailAddress,
              emailValidator: true,
            ),
            const SizedBox(height: 16),

            CustomTextFieldSignUp(
              controller: passwordController,
              label: StringConstants.passwordLabel,
              validatorMsg: StringConstants.passwordEmpty,
              obscureText: obscurePassword,

              suffixIcon: IconButton(
                icon: Icon(
                  obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: ColorConstants.hintColor,
                ),
                onPressed: onPasswordVisibilityToggle,
              ),
            ),
            const SizedBox(height: 16),

            const SizedBox(height: 12),
            Row(
              spacing: 4,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  StringConstants.alreadyUser,
                  style: TextStyle(fontSize: 16),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    StringConstants.signInTitle,
                    style: TextStyle(
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
                    : Text(
                        StringConstants.signUpButton,
                        style: const TextStyle(
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

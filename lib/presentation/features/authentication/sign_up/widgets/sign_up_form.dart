import 'package:flutter/material.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/core%20/constants/string_constants.dart';
import 'package:jay_insta_clone/presentation/features/authentication/sign_up/widgets/custom_text_field.dart';

class SignUpForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final bool agreedToTerms;
  final VoidCallback onPasswordVisibilityToggle;
  final ValueChanged<bool?> onTermsToggle;
  final VoidCallback onSubmit;
  final bool isLoading;

  const SignUpForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.agreedToTerms,
    required this.onPasswordVisibilityToggle,
    required this.onTermsToggle,
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
              controller: nameController,
              label: StringConstants.usernameLabel,
              validatorMsg: StringConstants.usernameEmpty,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              controller: emailController,
              label: StringConstants.emailLabel,
              validatorMsg: StringConstants.emailEmpty,
              keyboardType: TextInputType.emailAddress,
              emailValidator: true,
            ),
            const SizedBox(height: 16),

            CustomTextField(
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

            Row(
              children: [
                Checkbox(
                  value: agreedToTerms,
                  activeColor: ColorConstants.primaryColor,
                  onChanged: onTermsToggle,
                ),
                Expanded(
                  child: Text(
                    StringConstants.terms,
                    style: const TextStyle(
                      fontSize: 14,
                      color: ColorConstants.textSecondaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

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
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        StringConstants.signUpButton,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
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

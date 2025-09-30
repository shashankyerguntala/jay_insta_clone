import 'package:flutter/material.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/core%20/constants/string_constants.dart';
import 'package:jay_insta_clone/presentation/features/authentication/sign_up/widgets/sign_up_appbar.dart';
import 'package:jay_insta_clone/presentation/features/authentication/sign_up/widgets/sign_up_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;
  bool agreedToTerms = false;
  bool isLoading = false;

  void submit() {
    if (formKey.currentState!.validate()) {
      if (!agreedToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please agree to terms of use and privacy policy'),
            backgroundColor: ColorConstants.errorColor,
          ),
        );
        return;
      }

      setState(() => isLoading = true);

      Future.delayed(const Duration(seconds: 2), () {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign Up Successful!'),
            backgroundColor: ColorConstants.successColor,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SignUpAppBar(),
              const SizedBox(height: 24),
              SignUpForm(
                formKey: formKey,
                nameController: nameController,
                emailController: emailController,
                passwordController: passwordController,
                obscurePassword: obscurePassword,
                agreedToTerms: agreedToTerms,
                onPasswordVisibilityToggle: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },
                onTermsToggle: (value) {
                  setState(() {
                    agreedToTerms = value ?? false;
                  });
                },
                onSubmit: submit,
                isLoading: isLoading,
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

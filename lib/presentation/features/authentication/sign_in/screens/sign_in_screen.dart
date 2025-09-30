import 'package:flutter/material.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/presentation/features/authentication/sign_in/widgets/sign_in_appbar.dart';

import 'package:jay_insta_clone/presentation/features/authentication/sign_in/widgets/sign_in_form.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;

  bool isLoading = false;

  void submit() {
    if (formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      Future.delayed(const Duration(seconds: 2), () {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign In Successful!'),
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
              const SignInAppBar(),
              const SizedBox(height: 12),
              SignInForm(
                formKey: formKey,
                nameController: nameController,
                emailController: emailController,
                passwordController: passwordController,
                obscurePassword: obscurePassword,

                onPasswordVisibilityToggle: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
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

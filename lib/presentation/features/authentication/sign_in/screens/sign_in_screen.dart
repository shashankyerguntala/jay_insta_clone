// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:jay_insta_clone/core/constants/theme_constants.dart';
// import 'package:jay_insta_clone/presentation/features/authentication/sign_up/bloc/sign_up_bloc.dart';
// import 'package:jay_insta_clone/presentation/features/authentication/sign_up/bloc/sign_up_event.dart';
// import 'package:jay_insta_clone/presentation/features/authentication/sign_up/bloc/sign_up_state.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   bool _obscurePassword = true;
//   bool _agreedToTerms = false;

//   @override
//   void dispose() {
//     nameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   void _submit() {
//     if (_formKey.currentState!.validate()) {
//       if (!_agreedToTerms) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Please agree to terms of use and privacy policy'),
//             backgroundColor: ThemeConstants.errorColor,
//           ),
//         );
//         return;
//       }

//       context.read<SignUpBloc>().add(
//         SignUpSubmitted(
//           email: emailController.text.trim(),
//           username: nameController.text.trim(),
//           password: passwordController.text.trim(),
//         ),
//       );
//     }
//   }

//   void _togglePasswordVisibility() {
//     setState(() {
//       _obscurePassword = !_obscurePassword;
//     });
//   }

//   void _toggleTermsAgreement(bool? value) {
//     setState(() {
//       _agreedToTerms = value ?? false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ThemeConstants.backgroundColor,
//       body: BlocProvider(
//         create: (_) => SignUpBloc(),
//         child: BlocConsumer<SignUpBloc, SignUpState>(
//           listener: (context, state) {
//             if (state is SignUpFailure) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(state.message),
//                   backgroundColor: ThemeConstants.errorColor,
//                 ),
//               );
//             } else if (state is SignUpSuccess) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('Sign up successful!'),
//                   backgroundColor: ThemeConstants.successColor,
//                 ),
//               );
//             }
//           },
//           builder: (context, state) {
//             return SafeArea(
//               child: Column(
//                 children: [
//                   const SignUpAppBar(),
//                   Expanded(
//                     child: SignUpForm(
//                       formKey: _formKey,
//                       nameController: nameController,
//                       emailController: emailController,
//                       passwordController: passwordController,
//                       obscurePassword: _obscurePassword,
//                       agreedToTerms: _agreedToTerms,
//                       onPasswordVisibilityToggle: _togglePasswordVisibility,
//                       onTermsToggle: _toggleTermsAgreement,
//                       onSubmit: _submit,
//                       isLoading: state is SignUpLoading,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// // ==================== APP BAR WIDGET ====================
// class SignUpAppBar extends StatelessWidget {
//   const SignUpAppBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: ThemeConstants.paddingMedium,
//       child: Row(
//         children: [
//           IconButton(
//             icon: const Icon(Icons.arrow_back),
//             color: ThemeConstants.textPrimaryColor,
//             onPressed: () => Navigator.pop(context),
//           ),
//         ],
//       ),
//     );
//   }
// }


// // ==================== HEADER WIDGET ====================
// class SignUpHeader extends StatelessWidget {
//   const SignUpHeader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Sign up', style: ThemeConstants.headingLarge),
//         const SizedBox(height: ThemeConstants.spacingSmall),
//         Text('Please create a new account', style: ThemeConstants.bodyLarge),
//       ],
//     );
//   }
// }

// // ==================== NAME FIELD WIDGET ====================
// class NameField extends StatelessWidget {
//   final TextEditingController controller;

//   const NameField({super.key, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Name', style: ThemeConstants.labelStyle),
//         const SizedBox(height: ThemeConstants.spacingSmall),
//         TextFormField(
//           controller: controller,
//           decoration: ThemeConstants.inputDecoration(
//             hintText: 'Type something longer here...',
//           ),
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter your name';
//             }
//             return null;
//           },
//         ),
//       ],
//     );
//   }
// }

// // ==================== EMAIL FIELD WIDGET ====================
// class EmailField extends StatelessWidget {
//   final TextEditingController controller;

//   const EmailField({super.key, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Email', style: ThemeConstants.labelStyle),
//         const SizedBox(height: ThemeConstants.spacingSmall),
//         TextFormField(
//           controller: controller,
//           keyboardType: TextInputType.emailAddress,
//           decoration: ThemeConstants.highlightedInputDecoration(
//             hintText: 'myemail@gmail.com',
//           ),
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter your email';
//             }
//             if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
//               return 'Please enter a valid email';
//             }
//             return null;
//           },
//         ),
//       ],
//     );
//   }
// }

// // ==================== PASSWORD FIELD WIDGET ====================
// class PasswordField extends StatelessWidget {
//   final TextEditingController controller;
//   final bool obscurePassword;
//   final VoidCallback onVisibilityToggle;

//   const PasswordField({
//     super.key,
//     required this.controller,
//     required this.obscurePassword,
//     required this.onVisibilityToggle,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Password', style: ThemeConstants.labelStyle),
//         const SizedBox(height: ThemeConstants.spacingSmall),
//         TextFormField(
//           controller: controller,
//           obscureText: obscurePassword,
//           decoration: ThemeConstants.inputDecoration(
//             hintText: '••••••••',
//             suffixIcon: IconButton(
//               icon: Icon(
//                 obscurePassword
//                     ? Icons.visibility_off_outlined
//                     : Icons.visibility_outlined,
//                 color: ThemeConstants.primaryColor,
//               ),
//               onPressed: onVisibilityToggle,
//             ),
//           ),
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter your password';
//             }
//             if (value.length < 6) {
//               return 'Password must be at least 6 characters';
//             }
//             return null;
//           },
//         ),
//       ],
//     );
//   }
// }

// // ==================== TERMS CHECKBOX WIDGET ====================
// class TermsCheckbox extends StatelessWidget {
//   final bool agreedToTerms;
//   final ValueChanged<bool?> onChanged;

//   const TermsCheckbox({
//     super.key,
//     required this.agreedToTerms,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         SizedBox(
//           width: 24,
//           height: 24,
//           child: Checkbox(
//             value: agreedToTerms,
//             onChanged: onChanged,
//             activeColor: ThemeConstants.primaryColor,
//             shape: RoundedRectangleBorder(
//               borderRadius: ThemeConstants.borderRadiusSmall,
//             ),
//           ),
//         ),
//         const SizedBox(width: ThemeConstants.spacingSmall),
//         Expanded(
//           child: Text(
//             'Agree the terms of use and privacy policy',
//             style: ThemeConstants.bodyMedium,
//           ),
//         ),
//       ],
//     );
//   }
// }

// // ==================== SIGN UP BUTTON WIDGET ====================
// class SignUpButton extends StatelessWidget {
//   final VoidCallback onPressed;
//   final bool isLoading;

//   const SignUpButton({
//     super.key,
//     required this.onPressed,
//     required this.isLoading,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: 50,
//       child: ElevatedButton(
//         onPressed: isLoading ? null : onPressed,

//         child: isLoading
//             ? const SizedBox(
//                 width: 24,
//                 height: 24,
//                 child: CircularProgressIndicator(
//                   color: Colors.white,
//                   strokeWidth: 2,
//                 ),
//               )
//             : Text('Sign up'),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jay_insta_clone/presentation/features/authentication/sign_in/screens/sign_in_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      theme: ThemeData(textTheme: GoogleFonts.manropeTextTheme()),
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    );
  }
}

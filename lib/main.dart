import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:jay_insta_clone/core%20/di/di.dart';
import 'package:jay_insta_clone/core%20/routes/go_routes.dart';

void main() async {
  await Di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRoutes.router,
      title: 'Flutter Demo',

      theme: ThemeData(textTheme: GoogleFonts.manropeTextTheme()),
      debugShowCheckedModeBanner: false,
    );
  }
}

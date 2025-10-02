import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:jay_insta_clone/core%20/di/di.dart';
import 'package:jay_insta_clone/core%20/routes/go_routes.dart';

GoRoutes goRoutes = GoRoutes();
final Di getIt = Di();
void main() async {
  await getIt.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRoutes.goRoutes,
      title: 'Flutter Demo',

      theme: ThemeData(textTheme: GoogleFonts.manropeTextTheme()),
      debugShowCheckedModeBanner: false,
    );
  }
}

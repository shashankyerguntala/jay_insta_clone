import 'package:flutter/material.dart';
import 'package:jay_insta_clone/presentation/features/create_post/screens/create_post.dart';

import 'package:jay_insta_clone/presentation/features/home/widgets/post_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 242, 255),

      appBar: AppBar(
        centerTitle: true,
        title: Text('Twitter', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [Switch(value: true, onChanged: (value) {})],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            PostCard(
              email: "user@example.com",
              caption: "Flutter UI is awesome!",
              description: "Building custom widgets is easier than you think.",
              commentsCount: 12,
              createdAt: DateTime.now(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Icon(Icons.home, size: 32),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreatePost()),
                );
              },
              child: Icon(Icons.add, size: 32),
            ),
            Spacer(),
            Icon(Icons.man, size: 32),
          ],
        ),
      ),
    );
  }
}

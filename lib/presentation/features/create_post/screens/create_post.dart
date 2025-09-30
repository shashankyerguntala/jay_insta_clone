import 'package:flutter/material.dart';
import 'package:jay_insta_clone/presentation/features/home/screens/home_screen.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFormField(decoration: InputDecoration()),
          TextFormField(decoration: InputDecoration()),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              ),
              child: Icon(Icons.home, size: 32),
            ),
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

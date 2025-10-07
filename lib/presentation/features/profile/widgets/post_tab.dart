import 'package:flutter/material.dart';

import 'package:jay_insta_clone/domain/entity/post_entity.dart';

import 'package:jay_insta_clone/presentation/features/profile/widgets/posts_grid.dart';

class PostsTab extends StatelessWidget {
  final List<PostEntity> posts;

  const PostsTab({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return posts.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.article_outlined,
                  size: 64,
                  color: Color.fromARGB(128, 158, 158, 158),
                ),
                SizedBox(height: 16),
                Text("No posts available", style: TextStyle(fontSize: 16)),
              ],
            ),
          )
        : PostsGrid(status: "approved", posts: posts);
  }
}

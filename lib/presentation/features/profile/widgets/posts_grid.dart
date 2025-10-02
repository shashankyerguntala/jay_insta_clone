import 'package:flutter/material.dart';
import 'post_card.dart';

class PostsGrid extends StatelessWidget {
  final String status;
  const PostsGrid({super.key, required this.status});

  List<Map<String, dynamic>> _getPostsByStatus(String status) {
    final mockPosts = [
      {
        'title': 'Flutter Tips',
        'description': 'Desc',
        'date': '2d',
        'comments': 12,
        'status': 'approved',
      },
      {
        'title': 'State Management',
        'description': 'Desc',
        'date': '5d',
        'comments': 8,
        'status': 'approved',
      },
      {
        'title': 'Firebase Integration',
        'description': 'Desc',
        'date': '3h',
        'comments': 0,
        'status': 'pending',
      },
      {
        'title': 'Controversial Post',
        'description': 'Desc',
        'date': '3d',
        'comments': 0,
        'status': 'declined',
      },
    ];
    return mockPosts.where((post) => post['status'] == status).toList();
  }

  @override
  Widget build(BuildContext context) {
    final posts = _getPostsByStatus(status);

    if (posts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              status == 'approved'
                  ? Icons.article_outlined
                  : status == 'pending'
                  ? Icons.hourglass_empty
                  : Icons.cancel_outlined,
              size: 64,
              color: Colors.grey.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              status == 'approved'
                  ? "No approved posts yet"
                  : status == 'pending'
                  ? "No pending posts"
                  : "No declined posts",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: posts.length,
      itemBuilder: (context, index) => PostCard(post: posts[index]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jay_insta_clone/domain/entity/post_entity.dart';
import 'package:jay_insta_clone/presentation/features/profile/bloc/profile_bloc.dart';
import 'package:jay_insta_clone/presentation/features/profile/bloc/profile_event.dart';
import 'post_card.dart';

class PostsGrid extends StatelessWidget {
  final String status;
  final List<PostEntity> posts;

  const PostsGrid({super.key, required this.status, required this.posts});

  @override
  Widget build(BuildContext context) {
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
              color: const Color.fromARGB(128, 158, 158, 158),
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
      itemBuilder: (context, index) {
        final post = posts[index];
        return PostCard(
          post: post,
          editCallback: () {},
          deleteCallback: () {
            context.read<ProfileBloc>().add(DeletePostEvent(postId: post.id));
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:jay_insta_clone/presentation/features/moderator/widgets/moderator_post_card.dart';
import 'package:jay_insta_clone/presentation/features/super_admin/widgets/empty_state.dart';

class ModeratorPostsList extends StatelessWidget {
  final List<dynamic> posts;
  const ModeratorPostsList({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return const EmptyState(
        icon: Icons.post_add,
        message: "No pending posts",
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: posts.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) => ModeratorPostCard(post: posts[index]),
    );
  }
}

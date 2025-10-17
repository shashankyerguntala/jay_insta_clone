import 'package:flutter/material.dart';
import 'package:jay_insta_clone/presentation/features/moderator/widgets/moderator_comment_card.dart';

import 'package:jay_insta_clone/presentation/features/super_admin/widgets/empty_state.dart';

class ModeratorCommentsList extends StatelessWidget {
  final List<dynamic> comments;
  const ModeratorCommentsList({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty) {
      return const EmptyState(
        icon: Icons.comment,
        message: "No pending comments",
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: comments.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) =>
          ModeratorCommentCard(comment: comments[index]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/domain/entity/comment_entity.dart';

class CommentCard extends StatelessWidget {
  final CommentEntity comment;

  const CommentCard({super.key, required this.comment});

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) return "${difference.inSeconds}s ago";
    if (difference.inMinutes < 60) return "${difference.inMinutes}m ago";
    if (difference.inHours < 24) return "${difference.inHours}h ago";
    if (difference.inDays < 7) return "${difference.inDays}d ago";
    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorConstants.fillColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: ColorConstants.primaryLightColor.withAlpha(20),
            child: Icon(
              Icons.person,
              size: 20,
              color: ColorConstants.primaryColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.authorName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  comment.content,
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorConstants.textSecondaryColor,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _formatDate(comment.createdAt),
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorConstants.hintColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

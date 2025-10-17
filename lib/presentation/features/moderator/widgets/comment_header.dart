import 'package:flutter/material.dart';

import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/core%20/constants/theme_constants.dart';
import 'package:jay_insta_clone/core%20/helper_functions.dart';

class CommentHeader extends StatelessWidget {
  final dynamic comment;
  const CommentHeader({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: ColorConstants.primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.chat_bubble_outline,
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
                comment.content,
                style: ThemeConstants.bodyMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: HelperFunctions.getRoleColor(
                    comment.status,
                  ).withAlpha(20),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  comment.status.toUpperCase(),
                  style: ThemeConstants.bodySmall.copyWith(
                    color: HelperFunctions.getRoleColor(comment.status),
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/core%20/constants/theme_constants.dart';
import 'package:jay_insta_clone/core%20/helper_functions.dart';

class PostHeader extends StatelessWidget {
  final dynamic post;
  const PostHeader({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: ColorConstants.primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.article_outlined,
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
                post.title,
                style: ThemeConstants.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: HelperFunctions.getRoleColor(
                    post.status,
                  ).withAlpha(20),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  post.status.toUpperCase(),
                  style: ThemeConstants.bodySmall.copyWith(
                    color: HelperFunctions.getRoleColor(post.status),
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

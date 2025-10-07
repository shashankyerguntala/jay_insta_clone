import 'package:flutter/material.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/domain/entity/post_entity.dart';
import 'comment_card.dart';

class PostCard extends StatelessWidget {
  final PostEntity post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showPostDetails(context),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(6),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      post.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.textPrimaryColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                post.content,
                style: TextStyle(
                  fontSize: 14,
                  color: ColorConstants.textSecondaryColor,
                  height: 1.5,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.access_time_outlined,
                    size: 16,
                    color: ColorConstants.textSecondaryColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "${post.createdAt}",
                    style: TextStyle(
                      fontSize: 12,
                      color: ColorConstants.textSecondaryColor,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.comment_outlined,
                    size: 16,
                    color: ColorConstants.primaryColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "${post.comments.length} comments",
                    style: TextStyle(
                      fontSize: 12,
                      color: ColorConstants.textSecondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPostDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: ColorConstants.borderColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      post.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.textPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.access_time_outlined,
                    size: 16,
                    color: ColorConstants.textSecondaryColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "${post.createdAt}",
                    style: TextStyle(
                      fontSize: 13,
                      color: ColorConstants.textSecondaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                post.content,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  color: ColorConstants.textPrimaryColor,
                ),
              ),
              const SizedBox(height: 24),
              const Divider(color: ColorConstants.borderColor),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(
                    "Comments",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.textPrimaryColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstants.primaryLightColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "${post.comments.length}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...post.comments.map((comment) => CommentCard(comment: comment)),
            ],
          ),
        ),
      ),
    );
  }
}

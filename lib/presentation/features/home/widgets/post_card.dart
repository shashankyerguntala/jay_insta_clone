import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';

class PostCard extends StatelessWidget {
  final String email;
  final String caption;
  final String description;
  final int commentsCount;
  final DateTime createdAt;
  final VoidCallback onTap;

  const PostCard({
    super.key,
    required this.email,
    required this.caption,
    required this.description,
    required this.commentsCount,
    required this.createdAt,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: ColorConstants.borderColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  CircleAvatar(radius: 18, child: Text(email[0].toUpperCase())),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          email,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          DateFormat('dd MMM, hh:mm a').format(createdAt),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.more_horiz),
                ],
              ),
            ),

            if (caption.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  caption,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

            const SizedBox(height: 6),

            if (description.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(description, style: const TextStyle(fontSize: 14)),
              ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey, width: 0.2)),
              ),
              child: Row(
                children: [
                  Row(
                    children: const [
                      Icon(Icons.arrow_upward, size: 20, color: Colors.grey),
                      SizedBox(width: 4),
                      Text("12"),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_downward, size: 20, color: Colors.grey),
                    ],
                  ),
                  const SizedBox(width: 24),
                  Icon(Icons.comment, size: 20, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    "$commentsCount comments",
                    style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

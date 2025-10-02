import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  final String email;
  final String caption;
  final String description;
  final int commentsCount;
  final DateTime createdAt;

  const PostCard({
    super.key,
    required this.email,
    required this.caption,
    required this.description,
    required this.commentsCount,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  email,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  DateFormat('dd MMM, hh:mm a').format(createdAt),
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),

            const SizedBox(height: 8),

            if (caption.isNotEmpty)
              Text(
                caption,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),

            const SizedBox(height: 6),

            if (description.isNotEmpty)
              Text(description, style: const TextStyle(fontSize: 14)),

            const SizedBox(height: 12),

            Row(
              children: [
                const Icon(Icons.comment, size: 18, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  "$commentsCount comments",
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

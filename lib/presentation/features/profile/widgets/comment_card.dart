import 'package:flutter/material.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({super.key});

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
            backgroundColor: ColorConstants.primaryLightColor.withOpacity(0.2),
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
                const Text(
                  "User Name",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  "This is a sample comment on your post. Great content!",
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorConstants.textSecondaryColor,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "2 hours ago",
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

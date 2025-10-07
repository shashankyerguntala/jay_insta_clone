import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';

class ModeratorRequestDialog {
  static void show(BuildContext context, VoidCallback onRequestSent) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(
              Icons.shield_outlined,
              color: ColorConstants.primaryColor,
              size: 28,
            ),
            const SizedBox(width: 12),
            const Text(
              "Become a Moderator",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        content: const Text(
          "Do you want to request moderator privileges? Your request will be reviewed by admins.",
          style: TextStyle(fontSize: 15, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              "Cancel",
              style: TextStyle(color: ColorConstants.textSecondaryColor),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              context.pop();
              onRequestSent();
            },
            child: const Text(
              "Send Request",
              style: TextStyle(color: ColorConstants.backgroundColor),
            ),
          ),
        ],
      ),
    );
  }
}

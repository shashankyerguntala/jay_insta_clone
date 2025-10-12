import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/core%20/constants/string_constants.dart';

class FlagDialogue {
  static void show(BuildContext context, VoidCallback onFlag) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          StringConstants.flag,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(StringConstants.inappropriatePost),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              StringConstants.cancel,
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
              onFlag();
            },
            child: const Text(
              StringConstants.flagAsSensitive,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

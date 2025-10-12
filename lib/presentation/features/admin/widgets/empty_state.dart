import 'package:flutter/material.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/core%20/constants/theme_constants.dart';

class EmptyScreen extends StatelessWidget {
  final IconData icon;
  final String message;

  const EmptyScreen({super.key, required this.icon, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: ColorConstants.textSecondaryColor.withAlpha(128),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: ThemeConstants.bodyMedium.copyWith(
              color: ColorConstants.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

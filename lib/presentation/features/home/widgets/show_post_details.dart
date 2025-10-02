import 'package:flutter/material.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';

import 'package:jay_insta_clone/domain/entity/post_entity.dart';

class ShowPostDetails {
  static void showPostDetails(BuildContext context, PostEntity post) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
            color: ColorConstants.fillColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: ColorConstants.borderColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    post.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: ColorConstants.textPrimaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    post.content,
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorConstants.textSecondaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: ColorConstants.hintColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${post.createdAt}",
                      style: TextStyle(
                        color: ColorConstants.hintColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Divider(color: ColorConstants.hintColor, thickness: 1),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Comments",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: ColorConstants.textPrimaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                Expanded(
                  child: ListView.separated(
                    controller: controller,
                    itemCount:  5,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    //! here is the dummy data chnage when real api is hitting
                    itemBuilder: (context, index) {
                      final comment =  "This is a sample comment $index";

                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: ColorConstants.textSecondaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          comment.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: ColorConstants.textSecondaryColor,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

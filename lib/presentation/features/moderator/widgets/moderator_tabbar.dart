import 'package:flutter/material.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/core%20/constants/theme_constants.dart';

class ModeratorTabBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  const ModeratorTabBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      titleSpacing: 0,
      elevation: 0,
      title: Text('Moderator', style: ThemeConstants.headingMedium),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            decoration: BoxDecoration(
              color: ColorConstants.primaryColor.withAlpha(15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              labelColor: ColorConstants.primaryColor,
              unselectedLabelColor: ColorConstants.textSecondaryColor,
              indicator: BoxDecoration(
                color: ColorConstants.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelStyle: ThemeConstants.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: ThemeConstants.bodyMedium,
              tabs: const [
                Tab(text: 'Posts'),
                Tab(text: 'Comments'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

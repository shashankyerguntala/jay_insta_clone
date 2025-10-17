import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/core%20/constants/theme_constants.dart';
import 'package:jay_insta_clone/presentation/features/moderator/widgets/moderator_comments_list.dart';
import 'package:jay_insta_clone/presentation/features/moderator/widgets/moderator_posts_list.dart';

class ModeratorTabView extends StatelessWidget {
  final List<dynamic> posts;
  final List<dynamic> comments;

  const ModeratorTabView({
    super.key,
    required this.posts,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => context.go('/profile'),
            child: const Icon(Icons.arrow_back),
          ),
          centerTitle: true,
          titleSpacing: 0,
          elevation: 0,
          title: Text('Moderator', style: ThemeConstants.headingMedium),
          bottom: tabBar(),
        ),
        body: TabBarView(
          children: [
            ModeratorPostsList(posts: posts),
            ModeratorCommentsList(comments: comments),
          ],
        ),
      ),
    );
  }

  PreferredSize tabBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(56),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            color: ColorConstants.primaryColor.withAlpha(15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TabBar(
            labelColor: Colors.white,
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
    );
  }
}

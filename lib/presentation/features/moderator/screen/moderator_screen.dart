import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/core%20/constants/theme_constants.dart';
import 'package:jay_insta_clone/core%20/di/di.dart';
import 'package:jay_insta_clone/presentation/features/moderator/bloc/moderator_bloc.dart';
import 'package:jay_insta_clone/presentation/features/moderator/bloc/moderator_event.dart';
import 'package:jay_insta_clone/presentation/features/moderator/bloc/moderator_state.dart';

class ModeratorScreen extends StatelessWidget {
  const ModeratorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<ModeratorBloc>()..add(FetchAll()),
      child: BlocConsumer<ModeratorBloc, ModeratorState>(
        listener: (context, state) {
          if (state is PostActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Post ${state.action} successfully!'),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
          } else if (state is CommentActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Comment ${state.action} successfully!'),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ModeratorLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is ModeratorError) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48,
                      color: ColorConstants.textSecondaryColor,
                    ),
                    const SizedBox(height: 16),
                    Text(state.message, style: ThemeConstants.bodyMedium),
                  ],
                ),
              ),
            );
          } else if (state is ModeratorLoaded) {
            final posts = state.posts;
            final comments = state.comments;

            return DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  titleSpacing: 0,
                  elevation: 0,
                  title: Text('Moderator', style: ThemeConstants.headingMedium),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(56),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorConstants.primaryColor.withAlpha(15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TabBar(
                          labelColor: ColorConstants.primaryColor,
                          unselectedLabelColor:
                              ColorConstants.textSecondaryColor,
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
                ),
                body: TabBarView(
                  children: [
                    _buildPostsList(context, posts),
                    _buildCommentsList(context, comments),
                  ],
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildPostsList(BuildContext context, List<dynamic> posts) {
    if (posts.isEmpty) {
      return _buildEmptyState(
        icon: Icons.post_add,
        message: "No pending posts",
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: posts.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final post = posts[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          color: Theme.of(context).cardColor,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ColorConstants.primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.article_outlined,
                        size: 20,
                        color: ColorConstants.primaryColor,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.title,
                            style: ThemeConstants.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(post.status).withAlpha(20),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              post.status.toUpperCase(),
                              style: ThemeConstants.bodySmall.copyWith(
                                color: _getStatusColor(post.status),
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        context.read<ModeratorBloc>().add(RejectPost(post.id));
                      },
                      icon: const Icon(Icons.close, size: 18),
                      label: const Text('Decline'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<ModeratorBloc>().add(ApprovePost(post.id));
                      },
                      icon: const Icon(Icons.check, size: 18),
                      label: const Text('Approve'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCommentsList(BuildContext context, List<dynamic> comments) {
    if (comments.isEmpty) {
      return _buildEmptyState(
        icon: Icons.comment,
        message: "No pending comments",
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: comments.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final comment = comments[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          color: Theme.of(context).cardColor,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ColorConstants.primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.chat_bubble_outline,
                        size: 20,
                        color: ColorConstants.primaryColor,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            comment.content,
                            style: ThemeConstants.bodyMedium,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(
                                comment.status,
                              ).withAlpha(20),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              comment.status.toUpperCase(),
                              style: ThemeConstants.bodySmall.copyWith(
                                color: _getStatusColor(comment.status),
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        context.read<ModeratorBloc>().add(
                          RejectComment(comment.id),
                        );
                      },
                      icon: const Icon(Icons.close, size: 18),
                      label: const Text('Decline'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<ModeratorBloc>().add(
                          ApproveComment(comment.id),
                        );
                      },
                      icon: const Icon(Icons.check, size: 18),
                      label: const Text('Approve'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState({required IconData icon, required String message}) {
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return ColorConstants.textSecondaryColor;
    }
  }
}

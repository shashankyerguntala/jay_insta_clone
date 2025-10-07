import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/core%20/constants/theme_constants.dart';
import 'package:jay_insta_clone/core%20/di/di.dart';
import 'package:jay_insta_clone/presentation/features/admin/bloc/admin_bloc.dart';
import 'package:jay_insta_clone/presentation/features/admin/bloc/admin_event.dart';
import 'package:jay_insta_clone/presentation/features/admin/bloc/admin_state.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  
  Future<bool?> _showConfirmationDialog(
    BuildContext context,
    String action,
    String itemType,
  ) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text('$action $itemType?'),
        content: Text('Are you sure you want to $action this $itemType?'),
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => context.pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: action == 'Approve' 
                ? Colors.green 
                : Colors.red,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(action),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AdminBloc(adminUseCase: di(), moderatorUseCase: di())
            ..add(FetchAllAdmin()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text('Admin Dashboard', style: ThemeConstants.headingMedium),
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
                  controller: _tabController,
                  labelColor: ColorConstants.primaryColor,
                  unselectedLabelColor: ColorConstants.textSecondaryColor,
                  indicator: BoxDecoration(
                    color: ColorConstants.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelStyle: ThemeConstants.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: ThemeConstants.bodySmall,
                  tabs: const [
                    Tab(text: 'Posts'),
                    Tab(text: 'Comments'),
                    Tab(text: 'Moderators'),
                    
                  ],
                ),
              ),
            ),
          ),
        ),
        body: BlocConsumer<AdminBloc, AdminState>(
          listener: (context, state) {
            if (state is AdminError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is AdminLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AdminLoaded) {
              return TabBarView(
                controller: _tabController,
                children: [
                  _buildPostsTab(context, state),
                  _buildCommentsTab(context, state),
                  _buildModeratorRequestsTab(context, state),
                ],
              );
            }
            return _buildEmptyState(
              icon: Icons.inbox,
              message: 'No data available',
            );
          },
        ),
      ),
    );
  }

  Widget _buildPostsTab(BuildContext context, AdminLoaded state) {
    if (state.posts.isEmpty) {
      return _buildEmptyState(
        icon: Icons.article_outlined,
        message: 'No posts to review',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: state.posts.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final post = state.posts[index];
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
                            maxLines: 1,
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
                Text(
                  post.content,
                  style: ThemeConstants.bodySmall.copyWith(
                    color: ColorConstants.textSecondaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: post.status == 'pending'
                          ? () async {
                              final confirmed = await _showConfirmationDialog(
                                context,
                                'Reject',
                                'post',
                              );
                              if (confirmed == true && context.mounted) {
                                context.read<AdminBloc>().add(
                                      RejectPostAdmin(post.id),
                                    );
                              }
                            }
                          : null,
                      icon: const Icon(Icons.close, size: 18),
                      label: const Text('Reject'),
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
                      onPressed: post.status == 'pending'
                          ? () async {
                              final confirmed = await _showConfirmationDialog(
                                context,
                                'Approve',
                                'post',
                              );
                              if (confirmed == true && context.mounted) {
                                context.read<AdminBloc>().add(
                                      ApprovePostAdmin(post.id),
                                    );
                              }
                            }
                          : null,
                      icon: const Icon(Icons.check, size: 18),
                      label: const Text('Approve'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
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

  Widget _buildCommentsTab(BuildContext context, AdminLoaded state) {
    if (state.comments.isEmpty) {
      return _buildEmptyState(
        icon: Icons.chat_bubble_outline,
        message: 'No comments to review',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: state.comments.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final comment = state.comments[index];
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
                              color: _getStatusColor(comment.status)
                                  .withAlpha(20),
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
                      onPressed: comment.status == 'pending'
                          ? () async {
                              final confirmed = await _showConfirmationDialog(
                                context,
                                'Reject',
                                'comment',
                              );
                              if (confirmed == true && context.mounted) {
                                context.read<AdminBloc>().add(
                                      RejectCommentAdmin(comment.id),
                                    );
                              }
                            }
                          : null,
                      icon: const Icon(Icons.close, size: 18),
                      label: const Text('Reject'),
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
                      onPressed: comment.status == 'pending'
                          ? () async {
                              final confirmed = await _showConfirmationDialog(
                                context,
                                'Approve',
                                'comment',
                              );
                              if (confirmed == true && context.mounted) {
                                context.read<AdminBloc>().add(
                                      ApproveCommentAdmin(comment.id),
                                    );
                              }
                            }
                          : null,
                      icon: const Icon(Icons.check, size: 18),
                      label: const Text('Approve'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
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

  Widget _buildModeratorRequestsTab(BuildContext context, AdminLoaded state) {
    if (state.moderatorRequests.isEmpty) {
      return _buildEmptyState(
        icon: Icons.person_add_outlined,
        message: 'No moderator requests',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: state.moderatorRequests.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final request = state.moderatorRequests[index];
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
                        Icons.person_outline,
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
                            request.username,
                            style: ThemeConstants.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(request.status)
                                  .withAlpha(20),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              request.status,
                              style: ThemeConstants.bodySmall.copyWith(
                                color: _getStatusColor(request.status),
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
                      onPressed: request.status == 'PENDING'
                          ? () async {
                              final confirmed = await _showConfirmationDialog(
                                context,
                                'Reject',
                                'moderator request',
                              );
                              if (confirmed == true && context.mounted) {
                                context.read<AdminBloc>().add(
                                      RejectModeratorAdmin(request.id),
                                    );
                              }
                            }
                          : null,
                      icon: const Icon(Icons.close, size: 18),
                      label: const Text('Reject'),
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
                      onPressed: request.status == 'PENDING'
                          ? () async {
                              final confirmed = await _showConfirmationDialog(
                                context,
                                'Approve',
                                'moderator request',
                              );
                              if (confirmed == true && context.mounted) {
                                context.read<AdminBloc>().add(
                                      ApproveModeratorAdmin(request.id),
                                    );
                              }
                            }
                          : null,
                      icon: const Icon(Icons.check, size: 18),
                      label: const Text('Approve'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
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
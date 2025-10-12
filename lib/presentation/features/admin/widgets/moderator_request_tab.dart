import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/core%20/constants/theme_constants.dart';
import 'package:jay_insta_clone/core%20/helper_functions.dart';
import 'package:jay_insta_clone/presentation/features/admin/bloc/admin_event.dart';
import 'package:jay_insta_clone/presentation/features/admin/widgets/admin_dialogue.dart';
import '../bloc/admin_bloc.dart';

import 'empty_screen.dart';

class ModeratorRequestTab extends StatelessWidget {
  final List moderatorRequests;

  const ModeratorRequestTab({super.key, required this.moderatorRequests});

  @override
  Widget build(BuildContext context) {
    if (moderatorRequests.isEmpty) {
      return const EmptyScreen(
        icon: Icons.article_outlined,
        message: 'No posts to review',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: moderatorRequests.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final post = moderatorRequests[index];
        final isPending = post.status;

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
                              color: HelperFunctions.getRoleColor(
                                post.status,
                              ).withAlpha(20),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              post.status.toUpperCase(),
                              style: ThemeConstants.bodySmall.copyWith(
                                color: HelperFunctions.getRoleColor(
                                  post.status,
                                ),
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
                      onPressed: isPending
                          ? () async {
                              final confirmed = await ConfirmationDialog.show(
                                context,
                                action: 'Reject',
                                itemType: 'post',
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
                        disabledForegroundColor: Colors.grey,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: isPending
                          ? () async {
                              final confirmed = await ConfirmationDialog.show(
                                context,
                                action: 'Approve',
                                itemType: 'post',
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
                        disabledBackgroundColor: Colors.grey,
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
}

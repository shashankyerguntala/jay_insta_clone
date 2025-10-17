import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jay_insta_clone/presentation/features/moderator/bloc/moderator_bloc.dart';
import 'package:jay_insta_clone/presentation/features/moderator/bloc/moderator_event.dart';
import 'package:jay_insta_clone/presentation/features/moderator/widgets/actions_buttons.dart';
import 'package:jay_insta_clone/presentation/features/moderator/widgets/comment_header.dart';

class ModeratorCommentCard extends StatelessWidget {
  final dynamic comment;
  const ModeratorCommentCard({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommentHeader(comment: comment),
            const SizedBox(height: 12),
            ActionButtons(
              approve: () =>
                  context.read<ModeratorBloc>().add(ApproveComment(comment.id)),
              reject: () =>
                  context.read<ModeratorBloc>().add(RejectComment(comment.id)),
            ),
          ],
        ),
      ),
    );
  }
}

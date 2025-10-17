import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jay_insta_clone/presentation/features/moderator/bloc/moderator_bloc.dart';
import 'package:jay_insta_clone/presentation/features/moderator/bloc/moderator_event.dart';
import 'package:jay_insta_clone/presentation/features/moderator/widgets/actions_buttons.dart';
import 'package:jay_insta_clone/presentation/features/moderator/widgets/post_header.dart';

class ModeratorPostCard extends StatelessWidget {
  final dynamic post;
  const ModeratorPostCard({super.key, required this.post});

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
            PostHeader(post: post),
            const SizedBox(height: 12),
            ActionButtons(
              approve: () =>
                  context.read<ModeratorBloc>().add(ApprovePost(post.id)),
              reject: () =>
                  context.read<ModeratorBloc>().add(RejectPost(post.id)),
            ),
          ],
        ),
      ),
    );
  }
}

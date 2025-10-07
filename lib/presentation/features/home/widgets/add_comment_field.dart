import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/presentation/features/home/comment_bloc/bloc/comment_bloc.dart';
import 'package:jay_insta_clone/presentation/features/home/comment_bloc/bloc/comment_event.dart';
import 'package:jay_insta_clone/presentation/features/home/comment_bloc/bloc/comment_state.dart';


class AddCommentField extends StatefulWidget {
  final int userId;
  final int postId;

  const AddCommentField({
    super.key,
    required this.postId,
    required this.userId,
  });

  @override
  State<AddCommentField> createState() => _AddCommentFieldState();
}

class _AddCommentFieldState extends State<AddCommentField> {
  final TextEditingController commentController = TextEditingController();

  void sendComment() {
    final text = commentController.text.trim();
    if (text.isEmpty) return;


    context.read<CommentBloc>().add(
          SendCommentEvent(
            postId: widget.postId,
            userId: widget.userId,
            content: text,
          ),
        );

    commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommentBloc, CommentState>(
      listener: (context, state) {
        if (state is CommentSentSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Comment sent for approval'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is CommentSentFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to send comment: ${state.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: commentController,
              decoration: InputDecoration(
                hintText: "Write a comment...",
                filled: true,
                fillColor: const Color(0xFFF7F7F7),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: sendComment,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "Post",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

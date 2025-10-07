import 'package:equatable/equatable.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object?> get props => [];
}

class SendCommentEvent extends CommentEvent {
  final int postId;
  final int userId;
  final String content;

  const SendCommentEvent({
    required this.postId,
    required this.userId,
    required this.content,
  });

  @override
  List<Object?> get props => [postId, userId, content];
}

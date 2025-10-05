import 'package:equatable/equatable.dart';

abstract class ModeratorEvent extends Equatable {
  const ModeratorEvent();
  @override
  List<Object?> get props => [];
}

class FetchPosts extends ModeratorEvent {
  final String status;
  const FetchPosts({this.status = 'pending'});

  @override
  List<Object?> get props => [status];
}

class ApprovePost extends ModeratorEvent {
  final String postId;
  const ApprovePost(this.postId);

  @override
  List<Object?> get props => [postId];
}

class RejectPost extends ModeratorEvent {
  final String postId;

  const RejectPost(this.postId);

  @override
  List<Object?> get props => [postId];
}

class FetchComments extends ModeratorEvent {
  final String status;
  const FetchComments({this.status = 'pending'});

  @override
  List<Object?> get props => [status];
}

class ApproveComment extends ModeratorEvent {
  final String commentId;
  const ApproveComment(this.commentId);

  @override
  List<Object?> get props => [commentId];
}

class RejectComment extends ModeratorEvent {
  final String commentId;

  const RejectComment(this.commentId);

  @override
  List<Object?> get props => [commentId];
}

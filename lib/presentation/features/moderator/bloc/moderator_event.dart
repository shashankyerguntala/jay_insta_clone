import 'package:equatable/equatable.dart';

abstract class ModeratorEvent extends Equatable {
  const ModeratorEvent();
  @override
  List<Object?> get props => [];
}

class FetchAll extends ModeratorEvent {}

class ApprovePost extends ModeratorEvent {
  final int postId;

  const ApprovePost(this.postId);

  @override
  List<Object?> get props => [postId];
}

class RejectPost extends ModeratorEvent {
  final int postId;

  const RejectPost(this.postId);

  @override
  List<Object?> get props => [postId];
}

class ApproveComment extends ModeratorEvent {
  final int commentId;
  const ApproveComment(this.commentId);

  @override
  List<Object?> get props => [commentId];
}

class RejectComment extends ModeratorEvent {
  final int commentId;

  const RejectComment(this.commentId);

  @override
  List<Object?> get props => [commentId];
}

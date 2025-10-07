import 'package:equatable/equatable.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();
  @override
  List<Object?> get props => [];
}

class FetchAllAdmin extends AdminEvent {}

class ApprovePostAdmin extends AdminEvent {
  final int postId;
  const ApprovePostAdmin(this.postId);
  @override
  List<Object?> get props => [postId];
}

class RejectPostAdmin extends AdminEvent {
  final int postId;
  const RejectPostAdmin(this.postId);
  @override
  List<Object?> get props => [postId];
}

class ApproveCommentAdmin extends AdminEvent {
  final int commentId;
  const ApproveCommentAdmin(this.commentId);
  @override
  List<Object?> get props => [commentId];
}

class RejectCommentAdmin extends AdminEvent {
  final int commentId;
  const RejectCommentAdmin(this.commentId);
  @override
  List<Object?> get props => [commentId];
}

class ApproveModeratorAdmin extends AdminEvent {
  final int requestId;
  const ApproveModeratorAdmin(this.requestId);
  @override
  List<Object?> get props => [requestId];
}

class RejectModeratorAdmin extends AdminEvent {
  final int requestId;
  const RejectModeratorAdmin(this.requestId);
  @override
  List<Object?> get props => [requestId];
}

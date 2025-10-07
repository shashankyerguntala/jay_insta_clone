import 'package:equatable/equatable.dart';

abstract class SuperAdminEvent extends Equatable {
  const SuperAdminEvent();
  @override
  List<Object?> get props => [];
}

class FetchAllSuperAdmin extends SuperAdminEvent {}

class ApprovePostSuperAdmin extends SuperAdminEvent {
  final int postId;
  const ApprovePostSuperAdmin(this.postId);
  @override
  List<Object?> get props => [postId];
}

class RejectPostSuperAdmin extends SuperAdminEvent {
  final int postId;
  const RejectPostSuperAdmin(this.postId);
  @override
  List<Object?> get props => [postId];
}

class ApproveCommentSuperAdmin extends SuperAdminEvent {
  final int commentId;
  const ApproveCommentSuperAdmin(this.commentId);
  @override
  List<Object?> get props => [commentId];
}

class RejectCommentSuperAdmin extends SuperAdminEvent {
  final int commentId;
  const RejectCommentSuperAdmin(this.commentId);
  @override
  List<Object?> get props => [commentId];
}

class ApproveModeratorSuperAdmin extends SuperAdminEvent {
  final int requestId;
  const ApproveModeratorSuperAdmin(this.requestId);
  @override
  List<Object?> get props => [requestId];
}

class RejectModeratorSuperAdmin extends SuperAdminEvent {
  final int requestId;
  const RejectModeratorSuperAdmin(this.requestId);
  @override
  List<Object?> get props => [requestId];
}

class ApproveAdminSuperAdmin extends SuperAdminEvent {
  final int adminId;
  const ApproveAdminSuperAdmin(this.adminId);
  @override
  List<Object?> get props => [adminId];
}

class RejectAdminSuperAdmin extends SuperAdminEvent {
  final int adminId;
  const RejectAdminSuperAdmin(this.adminId);
  @override
  List<Object?> get props => [adminId];
}

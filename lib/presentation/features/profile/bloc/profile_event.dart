import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class FetchUserDetailsEvent extends ProfileEvent {
  final int userId;

  const FetchUserDetailsEvent({required this.userId});
}

class FetchApprovedPostsEvent extends ProfileEvent {
  final int userId;
  const FetchApprovedPostsEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class FetchDeclinedPostsEvent extends ProfileEvent {
  final int userId;
  const FetchDeclinedPostsEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class FetchPendingPostsEvent extends ProfileEvent {
  final int userId;
  const FetchPendingPostsEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class SignOutEvent extends ProfileEvent {}

class BecomeModeratorEvent extends ProfileEvent {}

import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class FetchApprovedPostsEvent extends ProfileEvent {
  final String userId;
  const FetchApprovedPostsEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class FetchDeclinedPostsEvent extends ProfileEvent {
  final String userId;
  const FetchDeclinedPostsEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class FetchPendingPostsEvent extends ProfileEvent {
  final String userId;
  const FetchPendingPostsEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class SignOutEvent extends ProfileEvent {}

class BecomeModeratorEvent extends ProfileEvent {}

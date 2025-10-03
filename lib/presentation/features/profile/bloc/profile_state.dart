import 'package:equatable/equatable.dart';

import 'package:jay_insta_clone/domain/entity/post_entity.dart';
import 'package:jay_insta_clone/domain/entity/user_entity.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User user;
  final List<PostEntity> approvedPosts;
  final List<PostEntity> pendingPosts;
  final List<PostEntity> declinedPosts;

  const ProfileLoaded({
    required this.user,
    required this.approvedPosts,
    required this.pendingPosts,
    required this.declinedPosts,
  });
  @override
  List<Object?> get props => [user, approvedPosts, pendingPosts, declinedPosts];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileSignedOut extends ProfileState {}

class ProfileModeratorSuccess extends ProfileState {}

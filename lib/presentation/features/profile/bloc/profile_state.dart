import 'package:equatable/equatable.dart';

import 'package:jay_insta_clone/domain/entity/post_entity.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final List<PostEntity> posts;

  const ProfileLoaded(this.posts);

  @override
  List<Object?> get props => [posts];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileSignedOut extends ProfileState {}

class ProfileModeratorSuccess extends ProfileState {}

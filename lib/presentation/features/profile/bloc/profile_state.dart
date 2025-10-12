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
  final String? msg;
  final UserEntity user;
  final List<PostEntity> approvedPosts;
  final List<PostEntity> pendingPosts;
  final List<PostEntity> declinedPosts;
  final bool isModeratorRequest;

  const ProfileLoaded({
    this.msg,
    required this.user,
    required this.approvedPosts,
    required this.pendingPosts,
    required this.declinedPosts,
    this.isModeratorRequest = false,
  });
}

extension ProfileLoadedCopy on ProfileLoaded {
  ProfileLoaded copyWith({
    String? msg,
    UserEntity? user,
    List<PostEntity>? approvedPosts,
    List<PostEntity>? pendingPosts,
    List<PostEntity>? declinedPosts,
    bool? isModeratorRequest,
  }) {
    return ProfileLoaded(
      msg: msg,
      user: user ?? this.user,
      approvedPosts: approvedPosts ?? this.approvedPosts,
      pendingPosts: pendingPosts ?? this.pendingPosts,
      declinedPosts: declinedPosts ?? this.declinedPosts,
      isModeratorRequest: isModeratorRequest ?? this.isModeratorRequest,
    );
  }
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileSignedOut extends ProfileState {}

class ProfileModeratorSuccess extends ProfileLoaded {
  const ProfileModeratorSuccess({
    required super.user,
    required super.approvedPosts,
    required super.pendingPosts,
    required super.declinedPosts,
    required super.isModeratorRequest,
  });
}

class EditSuccessState extends ProfileState {}

class EditErrorState extends ProfileState {}

class DeleteSuccessState extends ProfileState {}

class DeleteErrorState extends ProfileState {}

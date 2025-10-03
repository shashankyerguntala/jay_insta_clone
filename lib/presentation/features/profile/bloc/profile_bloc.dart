import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/domain/entity/post_entity.dart';
import 'package:jay_insta_clone/domain/entity/user_entity.dart';
import 'package:jay_insta_clone/domain/usecase/profile_usecase.dart';

import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileUsecase profileUsecase;

  ProfileBloc({required this.profileUsecase}) : super(ProfileInitial()) {
    on<FetchUserDetailsEvent>(_onFetchUserDetails);
    on<FetchApprovedPostsEvent>(_onFetchApprovedPosts);
    on<FetchPendingPostsEvent>(_onFetchPendingPosts);
    on<FetchDeclinedPostsEvent>(_onFetchDeclinedPosts);
    on<SignOutEvent>(_onSignOut);
    on<BecomeModeratorEvent>(_onBecomeModerator);
  }

  Future<void> _onFetchUserDetails(
    FetchUserDetailsEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    final Either<Failure, User> userResult = await profileUsecase
        .getUserProfile(event.userId);

    final Either<Failure, List<PostEntity>> approvedResult =
        await profileUsecase.getApprovedPosts(event.userId);
    final Either<Failure, List<PostEntity>> pendingResult = await profileUsecase
        .getPendingPosts(event.userId);
    final Either<Failure, List<PostEntity>> declinedResult =
        await profileUsecase.getDeclinedPosts(event.userId);

    userResult.fold((failure) => emit(ProfileError(failure.message)), (user) {
      approvedResult.fold((failure) => emit(ProfileError(failure.message)), (
        approvedPosts,
      ) {
        pendingResult.fold((failure) => emit(ProfileError(failure.message)), (
          pendingPosts,
        ) {
          declinedResult.fold(
            (failure) => emit(ProfileError(failure.message)),
            (declinedPosts) {
              emit(
                ProfileLoaded(
                  user: user,
                  approvedPosts: approvedPosts,
                  pendingPosts: pendingPosts,
                  declinedPosts: declinedPosts,
                ),
              );
            },
          );
        });
      });
    });
  }

  Future<void> _onFetchApprovedPosts(
    FetchApprovedPostsEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      emit(ProfileLoading());
      final result = await profileUsecase.getApprovedPosts(event.userId);
      result.fold(
        (failure) => emit(ProfileError(failure.message)),
        (approvedPosts) => emit(
          ProfileLoaded(
            user: currentState.user,
            approvedPosts: approvedPosts,
            pendingPosts: currentState.pendingPosts,
            declinedPosts: currentState.declinedPosts,
          ),
        ),
      );
    }
  }

  Future<void> _onFetchPendingPosts(
    FetchPendingPostsEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      emit(ProfileLoading());
      final result = await profileUsecase.getPendingPosts(event.userId);
      result.fold(
        (failure) => emit(ProfileError(failure.message)),
        (pendingPosts) => emit(
          ProfileLoaded(
            user: currentState.user,
            approvedPosts: currentState.approvedPosts,
            pendingPosts: pendingPosts,
            declinedPosts: currentState.declinedPosts,
          ),
        ),
      );
    }
  }

  Future<void> _onFetchDeclinedPosts(
    FetchDeclinedPostsEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      emit(ProfileLoading());
      final result = await profileUsecase.getDeclinedPosts(event.userId);
      result.fold(
        (failure) => emit(ProfileError(failure.message)),
        (declinedPosts) => emit(
          ProfileLoaded(
            user: currentState.user,
            approvedPosts: currentState.approvedPosts,
            pendingPosts: currentState.pendingPosts,
            declinedPosts: declinedPosts,
          ),
        ),
      );
    }
  }

  Future<void> _onSignOut(
    SignOutEvent event,
    Emitter<ProfileState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    emit(ProfileSignedOut());
  }

  Future<void> _onBecomeModerator(
    BecomeModeratorEvent event,
    Emitter<ProfileState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    final currentState = state;
    if (currentState is ProfileLoaded) {
      final updatedUser = currentState.user;//! here update when the user becomes the moderator
      emit(
        ProfileLoaded(
          user: updatedUser,
          approvedPosts: currentState.approvedPosts,
          pendingPosts: currentState.pendingPosts,
          declinedPosts: currentState.declinedPosts,
        ),
      );
    }

    emit(ProfileModeratorSuccess());
  }
}

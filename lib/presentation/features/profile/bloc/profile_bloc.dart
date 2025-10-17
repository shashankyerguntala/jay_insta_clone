import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jay_insta_clone/data%20/data_sources/local_data_sources/auth_local_storage.dart';
import 'package:jay_insta_clone/domain/usecase/post_usecase.dart';

import 'package:jay_insta_clone/domain/usecase/profile_usecase.dart';

import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileUsecase profileUsecase;
  final PostUseCase postUseCase;

  ProfileBloc(this.postUseCase, {required this.profileUsecase})
    : super(ProfileInitial()) {
    on<FetchUserDetailsEvent>(_onFetchUserDetails);
    on<FetchApprovedPostsEvent>(_onFetchApprovedPosts);
    on<FetchPendingPostsEvent>(_onFetchPendingPosts);
    on<FetchDeclinedPostsEvent>(_onFetchDeclinedPosts);
    on<SignOutEvent>(_onSignOut);
    on<BecomeModeratorEvent>(_onBecomeModerator);

    on<DeletePostEvent>(deletePostEvent);
  }

  Future<void> _onFetchUserDetails(
    FetchUserDetailsEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    final userResult = await profileUsecase.getUserProfile(event.userId);
    final approvedResult = await profileUsecase.getApprovedPosts(event.userId);
    final pendingResult = await profileUsecase.getPendingPosts(event.userId);
    final declinedResult = await profileUsecase.getDeclinedPosts(event.userId);

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
                  isModeratorRequest: false,
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
        (approvedPosts) =>
            emit(currentState.copyWith(approvedPosts: approvedPosts)),
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
        (pendingPosts) =>
            emit(currentState.copyWith(pendingPosts: pendingPosts)),
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
        (declinedPosts) =>
            emit(currentState.copyWith(declinedPosts: declinedPosts)),
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
    final currentState = state;
    if (currentState is ProfileLoaded) {
      emit(currentState.copyWith(isModeratorRequest: true));

      final uid = await AuthLocalStorage.getUid();
      final result = await profileUsecase.sendModeratorRequest(uid!);

      result.fold((failure) => emit(ProfileError(failure.message)), (_) {
        emit(
          ProfileModeratorSuccess(
            user: currentState.user,
            approvedPosts: currentState.approvedPosts,
            pendingPosts: currentState.pendingPosts,
            declinedPosts: currentState.declinedPosts,
            isModeratorRequest: true,
          ),
        );
      });
    }
  }

  FutureOr<void> deletePostEvent(
  DeletePostEvent event,
  Emitter<ProfileState> emit,
) async {
  emit(ProfileLoading());

  final uid = await AuthLocalStorage.getUid();

  final deleteResult = await postUseCase.deletePost(event.postId);
  await deleteResult.fold(
    (failure) async {
      emit(DeleteErrorState());
    },
    (_) async {
      // ✅ Once deletion succeeds, reload the whole profile
      final userResult = await profileUsecase.getUserProfile(uid!);
      final approvedResult = await profileUsecase.getApprovedPosts(uid);
      final pendingResult = await profileUsecase.getPendingPosts(uid);
      final declinedResult = await profileUsecase.getDeclinedPosts(uid);

      userResult.fold(
        (failure) => emit(ProfileError(failure.message)),
        (user) {
          approvedResult.fold(
            (failure) => emit(ProfileError(failure.message)),
            (approvedPosts) {
              pendingResult.fold(
                (failure) => emit(ProfileError(failure.message)),
                (pendingPosts) {
                  declinedResult.fold(
                    (failure) => emit(ProfileError(failure.message)),
                    (declinedPosts) {
                      emit(
                        ProfileLoaded(
                          msg: "Post deleted successfully",
                          user: user,
                          approvedPosts: approvedPosts,
                          pendingPosts: pendingPosts,
                          declinedPosts: declinedPosts,
                          isModeratorRequest: false,
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      );
    },
  );
}

}

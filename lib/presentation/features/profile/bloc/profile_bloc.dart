import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jay_insta_clone/domain/usecase/profile_usecase.dart';

import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileUsecase profileUsecase;

  ProfileBloc({required this.profileUsecase}) : super(ProfileInitial()) {
    on<FetchApprovedPostsEvent>(onFetchApproved);
    on<FetchDeclinedPostsEvent>(onFetchDeclined);
    on<FetchPendingPostsEvent>(onFetchPending);
    on<SignOutEvent>(onSignOut);
    on<BecomeModeratorEvent>(onBecomeModerator);
  }

  Future<void> onFetchApproved(
    FetchApprovedPostsEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    final result = await profileUsecase.getApprovedPosts(event.userId);
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (posts) => emit(ProfileLoaded(posts)),
    );
  }

  Future<void> onFetchDeclined(
    FetchDeclinedPostsEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    final result = await profileUsecase.getDeclinedPosts(event.userId);
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (posts) => emit(ProfileLoaded(posts)),
    );
  }

  Future<void> onFetchPending(
    FetchPendingPostsEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    final result = await profileUsecase.getPendingPosts(event.userId);
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (posts) => emit(ProfileLoaded(posts)),
    );
  }

  Future<void> onSignOut(SignOutEvent event, Emitter<ProfileState> emit) async {
    await Future.delayed(const Duration(seconds: 1));
    emit(ProfileSignedOut());
  }

  Future<void> onBecomeModerator(
    BecomeModeratorEvent event,
    Emitter<ProfileState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    emit(ProfileModeratorSuccess());
  }
}

class GetDeclinedPostsUseCase {}

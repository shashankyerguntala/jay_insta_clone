import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jay_insta_clone/domain/usecase/moderator_usecase.dart';
import 'moderator_event.dart';
import 'moderator_state.dart';

class ModeratorBloc extends Bloc<ModeratorEvent, ModeratorState> {
  final ModeratorUseCase useCase;

  ModeratorBloc({required this.useCase}) : super(ModeratorInitial()) {
    on<FetchPosts>(fetchPosts);
    on<ApprovePost>(approvePost);
    on<RejectPost>(rejectPost);
    on<FetchComments>(fetchComments);
    on<ApproveComment>(approveComment);
    on<RejectComment>(rejectComment);
  }

  Future<void> fetchPosts(
    FetchPosts event,
    Emitter<ModeratorState> emit,
  ) async {
    emit(ModeratorLoading());
    final result = await useCase.getPendingPosts();
    result.fold(
      (failure) => emit(ModeratorError(failure.message)),
      (posts) => emit(PostsLoaded(posts)),
    );
  }

  Future<void> approvePost(
    ApprovePost event,
    Emitter<ModeratorState> emit,
  ) async {
    final result = await useCase.approvePost(event.postId);
    result.fold(
      (failure) => emit(ModeratorError(failure.message)),
      (_) => emit(PostActionSuccess(event.postId, 'approved')),
    );
  }

  Future<void> rejectPost(
    RejectPost event,
    Emitter<ModeratorState> emit,
  ) async {
    final result = await useCase.rejectPost(event.postId);
    result.fold(
      (failure) => emit(ModeratorError(failure.message)),
      (_) => emit(PostActionSuccess(event.postId, 'rejected')),
    );
  }

  Future<void> fetchComments(
    FetchComments event,
    Emitter<ModeratorState> emit,
  ) async {
    emit(ModeratorLoading());
    final result = await useCase.getPendingComments();
    result.fold(
      (failure) => emit(ModeratorError(failure.message)),
      (comments) => emit(CommentsLoaded(comments)),
    );
  }

  Future<void> approveComment(
    ApproveComment event,
    Emitter<ModeratorState> emit,
  ) async {
    final result = await useCase.approveComment(event.commentId);
    result.fold(
      (failure) => emit(ModeratorError(failure.message)),
      (_) => emit(CommentActionSuccess(event.commentId, 'approved')),
    );
  }

  Future<void> rejectComment(
    RejectComment event,
    Emitter<ModeratorState> emit,
  ) async {
    final result = await useCase.rejectComment(event.commentId);
    result.fold(
      (failure) => emit(ModeratorError(failure.message)),
      (_) => emit(CommentActionSuccess(event.commentId, 'rejected')),
    );
  }
}

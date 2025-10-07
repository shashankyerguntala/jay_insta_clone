import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jay_insta_clone/domain/usecase/post_usecase.dart';
import 'package:jay_insta_clone/domain/usecase/send_comment_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SendCommentUseCase commentUseCase;
  final PostUseCase postUseCase;

  HomeBloc({required this.postUseCase, required this.commentUseCase})
    : super(HomeInitial()) {
    on<FetchPostsEvent>(onFetchPosts);
  }

  Future<void> onFetchPosts(
    FetchPostsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    Future.delayed(Duration(seconds: 1));

    final result = await postUseCase.getAllPosts();

    result.fold(
      (failure) => emit(HomeError(failure.message)),
      (posts) => emit(HomeLoaded(posts)),
    );
  }
}

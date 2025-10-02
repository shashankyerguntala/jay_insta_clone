import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jay_insta_clone/domain/usecase/post_usecase.dart';

import 'create_post_event.dart';
import 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  final PostUseCase postUseCase;

  CreatePostBloc({required this.postUseCase}) : super(CreatePostInitial()) {
    on<SubmitPostEvent>(_onSubmitPost);
  }

  Future<void> _onSubmitPost(
    SubmitPostEvent event,
    Emitter<CreatePostState> emit,
  ) async {
    emit(CreatePostLoading());

    final result = await postUseCase.createPost(event.title, event.content);

    result.fold(
      (failure) => emit(CreatePostError(error: failure.message)),
      (success) =>
          emit(CreatePostSuccess(message: "Post created successfully!")),
    );
  }
}

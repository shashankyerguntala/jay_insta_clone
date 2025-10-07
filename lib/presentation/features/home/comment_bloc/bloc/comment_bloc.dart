import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jay_insta_clone/core%20/shared_prefs/auth_local_storage.dart';

import 'package:jay_insta_clone/domain/usecase/send_comment_usecase.dart';
import 'comment_event.dart';
import 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final SendCommentUseCase commentUseCase;

  CommentBloc({required this.commentUseCase}) : super(CommentInitial()) {
    on<SendCommentEvent>(_sendComment);
  }

  Future<void> _sendComment(
    SendCommentEvent event,
    Emitter<CommentState> emit,
  ) async {
    emit(CommentSending());
    final userId = await AuthLocalStorage.getUid();
    final result = await commentUseCase.sendComment(
      userId!,
      event.postId,

      event.content,
    );

    result.fold(
      (failure) => emit(CommentSentFailure(failure.message)),
      (_) => emit(CommentSentSuccess()),
    );
  }
}

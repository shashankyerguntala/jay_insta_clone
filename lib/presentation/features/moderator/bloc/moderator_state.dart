import 'package:equatable/equatable.dart';
import 'package:jay_insta_clone/data%20/models/comment_model.dart';
import 'package:jay_insta_clone/data%20/models/post_model.dart';

abstract class ModeratorState extends Equatable {
  const ModeratorState();
  @override
  List<Object?> get props => [];
}

class ModeratorInitial extends ModeratorState {}

class ModeratorLoading extends ModeratorState {}

class ModeratorError extends ModeratorState {
  final String message;
  const ModeratorError(this.message);

  @override
  List<Object?> get props => [message];
}

class PostsLoaded extends ModeratorState {
  final List<PostModel> posts;
  const PostsLoaded(this.posts);

  @override
  List<Object?> get props => [posts];
}

class PostActionSuccess extends ModeratorState {
  final String postId;
  final String action;
  const PostActionSuccess(this.postId, this.action);

  @override
  List<Object?> get props => [postId, action];
}

class CommentsLoaded extends ModeratorState {
  final List<CommentModel> comments;
  const CommentsLoaded(this.comments);

  @override
  List<Object?> get props => [comments];
}

class CommentActionSuccess extends ModeratorState {
  final String commentId;
  final String action;
  const CommentActionSuccess(this.commentId, this.action);

  @override
  List<Object?> get props => [commentId, action];
}

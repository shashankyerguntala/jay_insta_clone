import 'package:equatable/equatable.dart';
import 'package:jay_insta_clone/domain/entity/comment_entity.dart';
import 'package:jay_insta_clone/domain/entity/post_entity.dart';

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

class ModeratorLoaded extends ModeratorState {
  final List<PostEntity> posts;
  final List<CommentEntity> comments;

  const ModeratorLoaded({this.posts = const [], this.comments = const []});

  ModeratorLoaded copyWith({
    List<PostEntity>? posts,
    List<CommentEntity>? comments,
  }) {
    return ModeratorLoaded(
      posts: posts ?? this.posts,
      comments: comments ?? this.comments,
    );
  }

  @override
  List<Object?> get props => [posts, comments];
}

class PostActionSuccess extends ModeratorState {
  final int postId;
  final String action;
  const PostActionSuccess(this.postId, this.action);
  @override
  List<Object?> get props => [postId, action];
}

class CommentActionSuccess extends ModeratorState {
  final int commentId;
  final String action;
  const CommentActionSuccess(this.commentId, this.action);
  @override
  List<Object?> get props => [commentId, action];
}

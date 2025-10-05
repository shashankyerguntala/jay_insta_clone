import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/data%20/models/post_model.dart';
import 'package:jay_insta_clone/data%20/models/comment_model.dart';

import 'package:jay_insta_clone/data%20/remote_data_sources/moderator_data_source.dart';

class ModeratorUseCase {
  final ModeratorDataSource dataSource;

  ModeratorUseCase({required this.dataSource});

  Future<Either<Failure, List<PostModel>>> getPendingPosts() {
    return dataSource.getPendingPosts();
  }

  Future<Either<Failure, bool>> approvePost(String postId) {
    return dataSource.approvePost(postId);
  }

  Future<Either<Failure, bool>> rejectPost(String postId) {
    return dataSource.rejectPost(postId);
  }

  Future<Either<Failure, List<CommentModel>>> getPendingComments() {
    return dataSource.getPendingComments();
  }

  Future<Either<Failure, bool>> approveComment(String commentId) {
    return dataSource.approveComment(commentId);
  }

  Future<Either<Failure, bool>> rejectComment(String commentId) {
    return dataSource.rejectComment(commentId);
  }
}

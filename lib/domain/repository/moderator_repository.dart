import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';

import 'package:jay_insta_clone/domain/entity/post_entity.dart';
import 'package:jay_insta_clone/domain/entity/comment_entity.dart';

abstract class ModeratorRepository {
  Future<Either<Failure, List<PostEntity>>> getPendingPosts();
  Future<Either<Failure, List<CommentEntity>>> getPendingComments();
  Future<Either<Failure, bool>> approvePost(String postId);
  Future<Either<Failure, bool>> rejectPost(String postId);
  Future<Either<Failure, bool>> approveComment(String commentId);
  Future<Either<Failure, bool>> rejectComment(String commentId);
}

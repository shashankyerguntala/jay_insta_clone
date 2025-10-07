import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/domain/entity/post_entity.dart';
import 'package:jay_insta_clone/domain/entity/comment_entity.dart';
import 'package:jay_insta_clone/domain/repository/moderator_repository.dart';

class ModeratorUseCase {
  final ModeratorRepository repository;

  ModeratorUseCase({required this.repository});

  Future<Either<Failure, List<PostEntity>>> getPendingPosts() async {
    return repository.getPendingPosts();
  }

  Future<Either<Failure, bool>> approvePost(int postId, int userId) async {
    return repository.approvePost(postId, userId);
  }

  Future<Either<Failure, bool>> rejectPost(int postId, int userId) async {
    return repository.rejectPost(postId, userId);
  }

  Future<Either<Failure, List<CommentEntity>>> getPendingComments() async {
    return repository.getPendingComments();
  }

  Future<Either<Failure, bool>> approveComment(
    int commentId,
    int userId,
  ) async {
    return repository.approveComment(commentId, userId);
  }

  Future<Either<Failure, bool>> rejectComment(int commentId, int userId) async {
    return repository.rejectComment(commentId, userId);
  }
}

import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';

import 'package:jay_insta_clone/data%20/remote_data_sources/moderator_data_source.dart';

import 'package:jay_insta_clone/domain/entity/post_entity.dart';
import 'package:jay_insta_clone/domain/entity/comment_entity.dart';
import 'package:jay_insta_clone/domain/repository/moderator_repository.dart';

class ModeratorRepositoryImpl implements ModeratorRepository {
  final ModeratorDataSource dataSource;

  ModeratorRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<PostEntity>>> getPendingPosts() async {
    final result = await dataSource.getPendingPosts();
    return result.fold(
      (failure) => Left(failure),
      (posts) => Right(posts.map<PostEntity>((e) => e).toList()),
    );
  }

  @override
  Future<Either<Failure, List<CommentEntity>>> getPendingComments() async {
    final result = await dataSource.getPendingComments();
    return result.fold(
      (failure) => Left(failure),
      (comments) => Right(comments.map<CommentEntity>((e) => e).toList()),
    );
  }

  @override
  Future<Either<Failure, bool>> approveComment(String commentId) {
    return dataSource.approveComment(commentId);
  }

  @override
  Future<Either<Failure, bool>> approvePost(String postId) {
    return dataSource.approvePost(postId);
  }

  @override
  Future<Either<Failure, bool>> rejectComment(String commentId) {
    return dataSource.rejectComment(commentId);
  }

  @override
  Future<Either<Failure, bool>> rejectPost(String postId) {
    return dataSource.rejectPost(postId);
  }
}

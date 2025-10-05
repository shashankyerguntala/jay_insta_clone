import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/dio_client.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/data%20/models/comment_model.dart';
import 'package:jay_insta_clone/data%20/models/post_model.dart';

class ModeratorDataSource {
  final DioClient dioClient;

  ModeratorDataSource({required this.dioClient});

  Future<Either<Failure, List<PostModel>>> getPendingPosts() async {
    final response = await dioClient.getRequest("/api/moderator/pending-posts");

    return response.fold((failure) => Left(failure), (data) {
      try {
        final posts = (data as List)
            .map((json) => PostModel.fromJson(json))
            .toList();
        return Right(posts);
      } catch (e) {
        return Left(Failure("Parsing error: $e"));
      }
    });
  }

  Future<Either<Failure, List<CommentModel>>> getPendingComments() async {
    final response = await dioClient.getRequest(
      "/api/moderator/pending-comments",
    );

    return response.fold((failure) => Left(failure), (data) {
      try {
        final comments = (data as List)
            .map((json) => CommentModel.fromJson(json))
            .toList();
        return Right(comments);
      } catch (e) {
        return Left(Failure("Parsing error: $e"));
      }
    });
  }

  Future<Either<Failure, bool>> approvePost(String postId) async {
    final response = await dioClient.putRequest(
      "/api/moderator/posts/$postId/approve",
    );

    return response.fold((failure) => Left(failure), (_) => const Right(true));
  }

  Future<Either<Failure, bool>> rejectPost(String postId) async {
    final response = await dioClient.putRequest(
      "/api/moderator/posts/$postId/reject",
    );

    return response.fold((failure) => Left(failure), (_) => const Right(true));
  }

  Future<Either<Failure, bool>> approveComment(String commentId) async {
    final response = await dioClient.putRequest(
      "/api/moderator/comments/$commentId/approve",
    );

    return response.fold((failure) => Left(failure), (_) => const Right(true));
  }

  Future<Either<Failure, bool>> rejectComment(String commentId) async {
    final response = await dioClient.putRequest(
      "/api/moderator/comments/$commentId/reject",
    );

    return response.fold((failure) => Left(failure), (_) => const Right(true));
  }
}

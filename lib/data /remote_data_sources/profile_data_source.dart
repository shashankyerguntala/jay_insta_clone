import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/constants/api_constants.dart';
import 'package:jay_insta_clone/core%20/network/dio_client.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';

import 'package:jay_insta_clone/data%20/models/post_model.dart';

class ProfileDataSource {
  final DioClient dioClient;

  ProfileDataSource({required this.dioClient});

  Future<Either<Failure, List<PostModel>>> getApprovedPosts(
    String userId,
  ) async {
    final response = await dioClient.getRequest(
      ApiConstants.userApprovedPosts(userId),
    );

    return response.fold((failure) => Left(failure), (data) {
      try {
        final posts = (data as List)
            .map((postJson) => PostModel.fromJson(postJson))
            .toList();
        return Right(posts);
      } catch (e) {
        return Left(Failure("Parsing error: ${e.toString()}"));
      }
    });
  }

  Future<Either<Failure, List<PostModel>>> getPendingPosts(
    String userId,
  ) async {
    final response = await dioClient.getRequest(
      ApiConstants.userPendingPosts(userId),
    );

    return response.fold((failure) => Left(failure), (data) {
      try {
        final posts = (data as List)
            .map((postJson) => PostModel.fromJson(postJson))
            .toList();
        return Right(posts);
      } catch (e) {
        return Left(Failure("Parsing error: ${e.toString()}"));
      }
    });
  }

  Future<Either<Failure, List<PostModel>>> getDeclinedPosts(
    String userId,
  ) async {
    final response = await dioClient.getRequest(
      ApiConstants.userDeclinededPosts(userId),
    );

    return response.fold((failure) => Left(failure), (data) {
      try {
        final posts = (data as List)
            .map((postJson) => PostModel.fromJson(postJson))
            .toList();
        return Right(posts);
      } catch (e) {
        return Left(Failure("Parsing error: ${e.toString()}"));
      }
    });
  }
}

import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/domain/entity/post_entity.dart';
import 'package:jay_insta_clone/domain/entity/user_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, String>> sendModeratorRequest(int userId);
  Future<Either<Failure, List<PostEntity>>> getApprovedPosts(int userId);
  Future<Either<Failure, List<PostEntity>>> getPendingPosts(int userId);
  Future<Either<Failure, List<PostEntity>>> getDeclinedPosts(int userId);
  Future<Either<Failure, UserEntity>> getUserProfile(int userId);
}

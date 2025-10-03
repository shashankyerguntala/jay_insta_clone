import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/domain/entity/post_entity.dart';
import 'package:jay_insta_clone/domain/entity/user_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, List<PostEntity>>> getApprovedPosts(String userId);
  Future<Either<Failure, List<PostEntity>>> getPendingPosts(String userId);
  Future<Either<Failure, List<PostEntity>>> getDeclinedPosts(String userId);
  Future<Either<Failure, User>> getUserProfile(String userId);
}

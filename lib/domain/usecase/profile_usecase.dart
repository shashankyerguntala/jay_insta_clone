import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';

import 'package:jay_insta_clone/domain/entity/post_entity.dart';
import 'package:jay_insta_clone/domain/entity/user_entity.dart';
import 'package:jay_insta_clone/domain/repository/profile_repository.dart';

class ProfileUsecase {
  final ProfileRepository repository;

  ProfileUsecase(this.repository);

  Future<Either<Failure, String>> sendModeratorRequest(int userId) {
    return repository.sendModeratorRequest(userId);
  }

  Future<Either<Failure, List<PostEntity>>> getApprovedPosts(int userId) {
    return repository.getApprovedPosts(userId);
  }

  Future<Either<Failure, List<PostEntity>>> getPendingPosts(int userId) {
    return repository.getPendingPosts(userId);
  }

  Future<Either<Failure, List<PostEntity>>> getDeclinedPosts(int userId) {
    return repository.getDeclinedPosts(userId);
  }

  Future<Either<Failure, UserEntity>> getUserProfile(int userId) {
    return repository.getUserProfile(userId);
  }
}

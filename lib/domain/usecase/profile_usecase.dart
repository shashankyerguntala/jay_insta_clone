import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/domain/entity/post_entity.dart';
import 'package:jay_insta_clone/domain/repository/profile_repository.dart';

class ProfileUsecase {
  final ProfileRepository repository;

  ProfileUsecase(this.repository);

  Future<Either<Failure, List<PostEntity>>> getApprovedPosts(String userId) {
    return repository.getApprovedPosts(userId);
  }

  Future<Either<Failure, List<PostEntity>>> getPendingPosts(String userId) {
    return repository.getPendingPosts(userId);
  }

  Future<Either<Failure, List<PostEntity>>> getDeclinedPosts(String userId) {
    return repository.getDeclinedPosts(userId);
  }
}

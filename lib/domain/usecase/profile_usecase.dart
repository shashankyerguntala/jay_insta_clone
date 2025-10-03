// import 'package:dartz/dartz.dart';
// import 'package:jay_insta_clone/core%20/network/failure.dart';
// import 'package:jay_insta_clone/domain/entity/post_entity.dart';
// import 'package:jay_insta_clone/domain/entity/user_entity.dart';
// import 'package:jay_insta_clone/domain/repository/profile_repository.dart';

// class ProfileUsecase {
//   final ProfileRepository repository;

//   ProfileUsecase(this.repository);

//   Future<Either<Failure, List<PostEntity>>> getApprovedPosts(String userId) {
//     return repository.getApprovedPosts(userId);
//   }

//   Future<Either<Failure, List<PostEntity>>> getPendingPosts(String userId) {
//     return repository.getPendingPosts(userId);
//   }

//   Future<Either<Failure, List<PostEntity>>> getDeclinedPosts(String userId) {
//     return repository.getDeclinedPosts(userId);
//   }

//   Future<Either<Failure,User>> getUserProfile(String userId){
//     return repository.getUserProfile(userId);
//   }
// }

import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/domain/entity/post_entity.dart';
import 'package:jay_insta_clone/domain/entity/user_entity.dart';
import 'package:jay_insta_clone/domain/repository/profile_repository.dart';

class ProfileUsecase {
  final ProfileRepository repository;

  ProfileUsecase({required this.repository});
  Future<Either<Failure, User>> getUserProfile(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final user = User(
      username: "John Doe",
      email: "john@example.com",
      role: "user",
      // isModerator: false,
    );

    return Right(user);
  }

  Future<Either<Failure, List<PostEntity>>> getApprovedPosts(
    String userId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final posts = List.generate(
      3,
      (index) => PostEntity(
        id: index,
        title: "Approved Post #$index",
        content: "This is the content of approved post #$index",
        author: "John Doe",
        createdAt: DateTime.now().subtract(Duration(hours: index)),
        status: 'approved',
      ),
    );
    return Right(posts);
  }

  Future<Either<Failure, List<PostEntity>>> getPendingPosts(
    String userId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final posts = List.generate(
      2,
      (index) => PostEntity(
        id: index + 10,
        title: "Pending Post #$index",
        content: "This is the content of pending post #$index",
        author: "John Doe",
        createdAt: DateTime.now().subtract(Duration(days: index)),
        status: 'pending',
      ),
    );
    return Right(posts);
  }

  Future<Either<Failure, List<PostEntity>>> getDeclinedPosts(
    String userId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final posts = List.generate(
      2,
      (index) => PostEntity(
        id: index + 20,
        title: "Declined Post #$index",
        content: "This is the content of declined post #$index",
        author: "John Doe",
        createdAt: DateTime.now().subtract(Duration(days: index + 2)),
        status: 'declined',
      ),
    );
    return Right(posts);
  }
}

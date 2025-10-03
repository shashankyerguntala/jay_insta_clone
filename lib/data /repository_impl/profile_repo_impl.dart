import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/data%20/models/user_model.dart';
import 'package:jay_insta_clone/data%20/remote_data_sources/profile_data_source.dart';
import 'package:jay_insta_clone/domain/entity/post_entity.dart';
import 'package:jay_insta_clone/domain/entity/user_entity.dart';
import 'package:jay_insta_clone/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource profileDataSource;

  ProfileRepositoryImpl({required this.profileDataSource});

  @override
  Future<Either<Failure, List<PostEntity>>> getApprovedPosts(
    String userId,
  ) async {
    final result = await profileDataSource.getApprovedPosts(userId);
    return result.map(
      (list) => list.map((post) => post.toEntity()).toList(),
    ); //! no left right is handled here might thorw error
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getPendingPosts(
    String userId,
  ) async {
    final result = await profileDataSource.getPendingPosts(userId);
    return result.map((list) => list.map((post) => post.toEntity()).toList());
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getDeclinedPosts(
    String userId,
  ) async {
    final result = await profileDataSource.getDeclinedPosts(userId);
    return result.map((list) => list.map((post) => post.toEntity()).toList());
  }

  @override
  Future<Either<Failure, User>> getUserProfile(String userId) async {
    final response = await profileDataSource.getUserProfle(userId);
    return response.fold(
      (failure) => left(failure),
      (data) => right(UserModel.fromJson(data)),
    );
  }
}

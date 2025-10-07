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
  Future<Either<Failure, List<PostEntity>>> getApprovedPosts(int userId) async {
    final result = await profileDataSource.getApprovedPosts(userId);

    return result.fold(
      (failure) => Left(failure),
      (postModels) => Right(
        postModels.map<PostEntity>((post) => post as PostEntity).toList(),
      ),
    );
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getPendingPosts(int userId) async {
    final result = await profileDataSource.getPendingPosts(userId);

    return result.fold(
      (failure) => Left(failure),
      (postModels) => Right(
        postModels.map<PostEntity>((post) => post as PostEntity).toList(),
      ),
    );
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getDeclinedPosts(int userId) async {
    final result = await profileDataSource.getDeclinedPosts(userId);

    return result.fold(
      (failure) => Left(failure),
      (postModels) => Right(
        postModels.map<PostEntity>((post) => post as PostEntity).toList(),
      ),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> getUserProfile(int userId) async {
    final response = await profileDataSource.getUserProfle(userId);
    return response.fold(
      (failure) => left(failure),
      (data) => right(UserModel.fromJson(data)),
    );
  }

  @override
  Future<Either<Failure, String>> sendModeratorRequest(int userId) async {
    final response = await profileDataSource.sendModeratorRequest(userId);
    return response.fold((failure) => left(failure), (data) => right(data));
  }
}

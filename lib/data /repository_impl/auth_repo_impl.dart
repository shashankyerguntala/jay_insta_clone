import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';

import 'package:jay_insta_clone/data%20/models/user_model.dart';
import 'package:jay_insta_clone/data%20/remote_data_sources/auth_data_source.dart';
import 'package:jay_insta_clone/domain/entity/user_entity.dart';
import 'package:jay_insta_clone/domain/repository/auth_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    final result = await remoteDataSource.loginUser(
      email: email,
      password: password,
    );

    if (result.isLeft()) {
      return Left(result.swap().getOrElse(() => Failure("Unknown")));
    }

    final data = result.getOrElse(() => {});

    try {
      final token = data["token"];
      if (token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("jwt_token", token);
      }

      final user = UserModel.fromJson(data);

      return Right(user);
    } catch (e) {
      return Left(Failure("Error processing login response: $e"));
    }
  }

  @override
  Future<Either<Failure, String>> register({
    required String username,
    required String email,
    required String password,
  }) async {
    final result = await remoteDataSource.registerUser(
      username: username,
      email: email,
      password: password,
    );

    return result.fold((failure) => Left(failure), (data) => Right(data));
  }
}

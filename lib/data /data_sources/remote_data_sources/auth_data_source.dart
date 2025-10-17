import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/constants/api_constants.dart';

import 'package:jay_insta_clone/core%20/network/dio_client.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/data%20/data_sources/local_data_sources/auth_local_storage.dart';
import 'package:jay_insta_clone/data%20/models/user_model.dart';

class AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSource({required this.dioClient});
  //! sign in
  Future<Either<Failure, String>> registerUser({
    required String username,
    required String email,
    required String password,
  }) async {
    final result = await dioClient.postRequest(
      ApiConstants.register,
      data: {"username": username, "email": email, "password": password},
    );

    return result.fold(
      (failure) => Left(failure),
      (data) => Right(data as String),
    );
  }

  //! sign up
  Future<Either<Failure, UserModel>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final result = await dioClient.postRequest(
        ApiConstants.login,
        data: {"email": email, "password": password},
      );

      return result.fold((failure) => Left(failure), (data) {
        final token = data["token"];
        if (token != null) {
          AuthLocalStorage.saveToken(token);
        }

        final user = UserModel.fromJson(data);
        return Right(user);
      });
    } catch (e) {
      return Left(Failure("Error processing login response: $e"));
    }
  }
}

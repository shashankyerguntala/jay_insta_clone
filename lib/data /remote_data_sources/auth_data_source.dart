import 'package:dartz/dartz.dart';

import 'package:jay_insta_clone/core%20/network/dio_client.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';

class AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSource({required this.dioClient});

  //! Sign Up
  Future<Either<Failure, String>> registerUser({
    required String username,
    required String email,
    required String password,
  }) async {
    final result = await dioClient.postRequest(
      'localhost:8080/api/users/signup',
      data: {"username": username, "email": email, "password": password},
    );

    return result.fold(
      (failure) => Left(failure),
      (data) => Right(data as String),
    );
  }

  //! Sign In
  Future<Either<Failure, Map<String, dynamic>>> loginUser({
    required String email,
    required String password,
  }) async {
    final result = await dioClient.postRequest(
      'localhost:8080/api/auth/login',
      data: {"email": email, "password": password},
    );

    return result.fold(
      (failure) => Left(failure),
      (data) => Right(data as Map<String, dynamic>),
    );
  }
}

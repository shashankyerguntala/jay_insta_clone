import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import 'package:jay_insta_clone/core%20/network/failure.dart';

class DioClient {
  final Dio dio;

  DioClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: 'https://isadora-eupneic-kaden.ngrok-free.dev',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {"Content-Type": "application/json"},
        ),
      );

  //! get
  Future<Either<Failure, dynamic>> getRequest(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(
        Failure(e.response?.data["message"] ?? e.message ?? "Unknown error"),
      );
    }
  }

  //!post

  Future<Either<Failure, dynamic>> postRequest(
    String endpoint, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await dio.post(endpoint, data: data);
      return Right(response.data);
    } on DioException catch (e) {
      return Left(
        Failure(e.response?.data["message"] ?? e.message ?? "Unknown error"),
      );
    }
  }

  //!put
  Future<Either<Failure, dynamic>> putRequest(
    String endpoint, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.put(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(
        Failure(e.response?.data["message"] ?? e.message ?? "Unknown error"),
      );
    }
  }

  //!delete
  Future<Either<Failure, dynamic>> deleteRequest(
    String endpoint, {
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.delete(
        endpoint,
        options: Options(headers: headers),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(
        Failure(e.response?.data["message"] ?? e.message ?? "Unknown error"),
      );
    }
  }

  //!patch
  Future<Either<Failure, dynamic>> patchRequest(
    String endpoint, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.patch(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(
        Failure(e.response?.data["message"] ?? e.message ?? "Unknown error"),
      );
    }
  }
}

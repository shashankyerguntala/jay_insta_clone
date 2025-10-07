import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/constants/api_constants.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  final Dio dio;
  DioClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
          headers: {"Content-Type": "application/json"},
        ),
      ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (options.path.contains("login") ||
              options.path.contains("register")) {
            return handler.next(options);
          }

          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString("jwt_token");

          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },
      ),
    );
  }

  Future<Either<Failure, dynamic>> getRequest(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(
        endpoint,
        queryParameters: queryParameters,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(
        Failure(e.response?.data["message"] ?? e.message ?? "Unknown error"),
      );
    }
  }

  Future<Either<Failure, dynamic>> postRequest(
    String endpoint, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await dio.post(
        endpoint,
        data: data,
        options: Options(validateStatus: (_) => true),
      );

      if (response.statusCode == 404 || response.statusCode == 401) {
        return Left(Failure("Enter Registered Credentials"));
      } else if (response.statusCode! >= 400) {
        return Left(
          Failure(
            response.data?["message"] ??
                "Something went wrong (${response.statusCode})",
          ),
        );
      } else if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Right(response.data);
      } else {
        return Left(Failure("Unexpected status code: ${response.statusCode}"));
      }
    } on DioException catch (e) {
      return Left(
        Failure(e.response?.data["message"] ?? e.message ?? "Unknown error"),
      );
    }
  }

  Future<Either<Failure, dynamic>> putRequest(
    String endpoint, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await dio.put(endpoint, data: data);
      return Right(response.data);
    } on DioException catch (e) {
      return Left(
        Failure(e.response?.data["message"] ?? e.message ?? "Unknown error"),
      );
    }
  }

  Future<Either<Failure, dynamic>> deleteRequest(String endpoint) async {
    try {
      final response = await dio.delete(endpoint);
      return Right(response.data);
    } on DioException catch (e) {
      return Left(
        Failure(e.response?.data["message"] ?? e.message ?? "Unknown error"),
      );
    }
  }

  Future<Either<Failure, dynamic>> patchRequest(
    String endpoint, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await dio.patch(endpoint, data: data);
      return Right(response.data);
    } on DioException catch (e) {
      return Left(
        Failure(e.response?.data["message"] ?? e.message ?? "Unknown error"),
      );
    }
  }
}

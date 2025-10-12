import 'package:dio/dio.dart';
import 'failure.dart';

class ErrorHandler {
  static Failure handle(DioException e) {
    if (e.response != null) {
      final status = e.response!.statusCode;

      if (status! >= 500) {
        return ServerError("User Not Found!");
      } else if (status == 401) {
        return UnauthorizedAccess("Incorrect email/password");
      } else if (status == 409) {
        return ClientError('User is already registered !');
      } else if (status >= 400) {
        return ClientError("Client side error");
      }
    } else if (e.type == DioExceptionType.connectionTimeout) {
      return ClientError("Connection timeout. Check your internet.");
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return ClientError("Server took too long to respond.");
    } else if (e.type == DioExceptionType.unknown) {
      return ClientError("Unexpected network error.");
    }

    return Failure(e.message ?? "Unknown error occurred");
  }
}

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInterceptor extends Interceptor {
  String? token;

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("jwt_token");
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!options.path.contains("login") && !options.path.contains("register")) {
      token ??= await getToken();
      if (token != null) {
        options.headers["Authorization"] = "Bearer $token";
      }
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }
}

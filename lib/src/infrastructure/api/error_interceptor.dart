import 'package:dio/dio.dart';

class OnError extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response.toString().isNotEmpty) {
      throw (err.response.toString());
    } else {
      handler.reject(err);
    }
  }
}

class ApiException implements Exception {
  String errorMessage;
  ApiException(this.errorMessage) : super();
}

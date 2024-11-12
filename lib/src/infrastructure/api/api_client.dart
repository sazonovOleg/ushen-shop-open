import 'package:dio/dio.dart';
import 'error_interceptor.dart';
import 'on_request_interceptor.dart';

class ApiClient {
  final Dio dio = Dio();
  final String baseUrl = 'https://www.cdn-ushen.ru/';
  final String testUrl = 'http://localhost:3020/';

  ApiClient() {
    dio.options.baseUrl = 'https://www.cdn-ushen.ru/';
    dio.interceptors.add(OnError());
    dio.interceptors.add(
      OnRequest(),
    );
  }
}
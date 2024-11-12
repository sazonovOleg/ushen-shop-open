import 'dart:convert';
import 'package:dio/dio.dart';

class OnRequest extends Interceptor {
  OnRequest();

  final String authName = base64Encode(
    utf8.encode('ushen_login'),
  );

  final String authPass = base64Encode(
    utf8.encode('ushen_pass'),
  );

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['authName'] = authName;
    options.headers['authPass'] = authPass;

    super.onRequest(options, handler);
  }
}

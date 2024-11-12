import 'package:TeaShopApp/src/features/auth/data/models/login_model/login_model.dart';
import 'package:TeaShopApp/src/features/auth/data/models/regist_model/registration_model.dart';
import 'package:dio/dio.dart';
import 'auth_constants.dart';

class AuthApi {
  final Dio _dio;

  AuthApi(this._dio);

  Future<String> login(LoginModel login) async {
    final response = await _dio.post(
      AuthApiConstants.login,
      data: {
        'email': login.email,
        'password': login.password,
      },
    );

    return response.data.toString();
  }

  Future<String> registration(RegistrationModel reg) async {
    final response = await _dio.post(
      AuthApiConstants.registration,
      data: {
        'name': reg.name,
        'lastName': reg.lastName,
        'phone': reg.phone,
        'email': reg.email,
        'password': reg.password,
        'isMobile': true,
      },
    );

    return response.data.toString();
  }

  Future<String> verifyProfile(String emailToken) async {
    final response = await _dio.post(
      AuthApiConstants.verifyEmail,
      data: {
        'emailToken': emailToken,
      },
    );

    return response.data;
  }

  Future<void> resetPass(String email) async {
    await _dio.post(
      AuthApiConstants.resetPass,
      data: {
        'email': email,
      },
    );
  }
}

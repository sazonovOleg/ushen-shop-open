import 'package:TeaShopApp/src/features/auth/data/api/auth_api.dart';
import 'package:TeaShopApp/src/features/auth/data/models/login_model/login_model.dart';
import 'package:TeaShopApp/src/features/auth/data/models/regist_model/registration_model.dart';

import 'auth_storage.dart';

class AuthRepo {
  final AuthApi _api;
  final AuthStorage _authStorage;

  AuthRepo(this._api, this._authStorage);

  Future<bool> login(LoginModel loginModel) async {
    final token = await _api.login(loginModel);

    return token.length > 15 ? true : false;
  }

  Future<String> registration(RegistrationModel registrationModel) async {
    final token = await _api.registration(registrationModel);

    return token;
  }

  Future<void> resetPass(String email) async {
    await _api.resetPass(email);
  }

  Future<String> verifyProfile(String token) async {
    return await _api.verifyProfile(token);
  }

  Future<void> setProfileLogging(bool value) async {
    await _authStorage.setProfileLogin(value);
  }

  Future<bool> getProfileLogging() async {
    final isLogin = await _authStorage.getProfileLogin();

    return isLogin ?? false;
  }
}

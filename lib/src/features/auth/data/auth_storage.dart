import 'package:TeaShopApp/src/infrastructure/hive/hive_storage.dart';
import 'package:TeaShopApp/src/infrastructure/shared_pref/shared_pref.dart';

class AuthStorage {
  final HiveStorage _hiveStorage;
  final SharedPref _sharedPref;

  AuthStorage(
    this._hiveStorage,
    this._sharedPref,
  );

  final String _userLogin = 'user_token';

  Future<void> setProfileLogin(bool value) async {
    await _sharedPref.setBool(_userLogin, value);
  }

  Future<bool?> getProfileLogin() async {
    return await _sharedPref.getBool(_userLogin);
  }
}

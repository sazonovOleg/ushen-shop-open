import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  late final SharedPreferences sharedPref;

  Future<SharedPref> init() async {
    sharedPref = await SharedPreferences.getInstance();

    return this;
  }

  Future<void> setString(String key, String value) async {
    await sharedPref.setString(key, value);
  }

  Future<String?> getString(String key) async {
    return sharedPref.getString(key);
  }

  Future<void> setBool(String key, bool value) async {
    await sharedPref.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    return sharedPref.getBool(key);
  }

  Future<void> setInt(String key, int value) async {
    await sharedPref.setInt(key, value);
  }

  Future<int?> getInt(String key) async {
    return sharedPref.getInt(key);
  }
}

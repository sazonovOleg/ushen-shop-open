import 'package:TeaShopApp/src/features/profile/domain/models/profile_hive_model.dart';
import 'package:TeaShopApp/src/infrastructure/hive/hive_storage.dart';
import 'package:TeaShopApp/src/infrastructure/shared_pref/shared_pref.dart';

class ProfileStorage {
  final HiveStorage _hiveStorage;
  final SharedPref _sharedPref;

  ProfileStorage(
    this._hiveStorage,
    this._sharedPref,
  );

  final String _profileKey = 'profile_key';
  final String _profileId = 'profile_id_key';

  Future<void> saveProfileInfo(ProfileHiveModel profileModel) async {
    await _hiveStorage.saveBox(_profileKey, profileModel);
  }

  Future<ProfileHiveModel> getProfileInfo() async {
    final profileInfo = await _hiveStorage.getBox(_profileKey);

    return profileInfo;
  }

  Future<void> clearProfileInfo() async {
    await _hiveStorage.clearBox(_profileKey);
    await _sharedPref.setInt(_profileId, 0);
  }

  Future<void> saveProfileId(int id) async {
    await _sharedPref.setInt(_profileId, id);
  }

  Future<int> getProfileId() async {
    final id = await _sharedPref.getInt(_profileId);

    return id ?? 0;
  }
}

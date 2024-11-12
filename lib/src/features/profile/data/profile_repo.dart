import 'package:TeaShopApp/src/features/profile/data/api/profile_api.dart';
import 'package:TeaShopApp/src/features/profile/data/profile_storage.dart';
import 'package:TeaShopApp/src/features/profile/domain/models/profile_hive_model.dart';

class ProfileRepo {
  final ProfileApi _profileApi;
  final ProfileStorage _profileStorage;

  ProfileRepo(
    this._profileApi,
    this._profileStorage,
  );

  Future<void> saveProfileInfo(String email) async {
    final data = await _profileApi.getProfileInfo(email);

    _profileStorage.saveProfileInfo(
      ProfileHiveModel(
        id: data.id,
        name: data.name,
        lastName: data.lastName,
        email: data.email,
        phone: data.phone,
        isVerified: data.isVerified,
        discount: data.discount.toString(),
        totalPurchaseAmount: data.totalPurchaseAmount.toString(),
      ),
    );
  }

  Future<ProfileHiveModel> getProfileInfo() async {
    final profile = await _profileStorage.getProfileInfo();

    await saveProfileId(profile.id);

    if (profile.email.isNotEmpty) {
      return profile;
    } else {
      return ProfileHiveModel.empty();
    }
  }

  Future<void> clearProfileInfo() async {
    await _profileStorage.clearProfileInfo();
  }

  Future<void> saveProfileId(int id) async {
    await _profileStorage.saveProfileId(id);
  }

  Future<int> getProfileId() async {
    return await _profileStorage.getProfileId();
  }

  Future<void> changeProfileData(String infoType, String infoValue) async {
    final profileId = await getProfileId();

    if (profileId > 0) {
      await _profileApi
          .changeProfileData(
            profileId,
            infoType,
            infoValue,
          )
          .then(
            (value) => {
              if (value.name.isNotEmpty)
                _profileStorage.saveProfileInfo(
                  ProfileHiveModel(
                    id: value.id,
                    name: value.name,
                    lastName: value.lastName,
                    email: value.email,
                    phone: value.phone,
                    isVerified: value.isVerified,
                    discount: value.discount.toString(),
                    totalPurchaseAmount: value.totalPurchaseAmount.toString(),
                  ),
                )
            },
          );
    }
  }
}

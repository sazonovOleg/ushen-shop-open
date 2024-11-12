import 'package:TeaShopApp/src/features/profile/data/profile_repo.dart';
import 'package:TeaShopApp/src/features/profile/domain/models/profile_hive_model.dart';

class ProfileService {
  final ProfileRepo _profileRepo;

  ProfileService(
    this._profileRepo,
  );

  Future<void> saveProfile(String email) async {
    await _profileRepo.saveProfileInfo(email);
  }

  Future<ProfileHiveModel> getProfile() async {
    return await _profileRepo.getProfileInfo();
  }

  Future<void> clearProfileInfo() async {
    await _profileRepo.clearProfileInfo();
  }

  Future<void> saveProfileId(int id) async {
    await _profileRepo.saveProfileId(id);
  }

  Future<int> getProfileId() async {
    return await _profileRepo.getProfileId();
  }

  Future<void> changeProfileData(String infoType, String infoValue) async {
    await _profileRepo.changeProfileData(
      infoType,
      infoValue,
    );
  }
}

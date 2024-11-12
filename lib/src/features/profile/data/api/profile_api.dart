import 'package:TeaShopApp/src/features/profile/data/api/profile_api_constants.dart';
import 'package:TeaShopApp/src/features/profile/data/models/profile_model_resp.dart';
import 'package:dio/dio.dart';

class ProfileApi {
  final Dio _dio;

  ProfileApi(this._dio);

  Future<ProfileModelResponse> getProfileInfo(String email) async {
    final response = await _dio.post(
      ProfileApiConstants.userInfo,
      data: {
        'email': email,
      },
    );

    return profileResponseFromJson(response.data);
  }

  Future<ProfileModelResponse> changeProfileData(
    int id,
    String infoType,
    String infoValue,
  ) async {
    final response = await _dio.post(
      ProfileApiConstants.changeUserData,
      data: {
        'id': id,
        'infoType': infoType,
        'infoValue': infoValue,
      },
    );

    return profileResponseFromJson(response.data);
  }

  Future<bool> changeProfilePass(
      int id, String oldPassword, String newPassword) async {
    final response = await _dio.post(
      ProfileApiConstants.changeUserPass,
      data: {
        'id': id,
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      },
    );

    return response.data;
  }
}

import 'package:TeaShopApp/src/features/cart/domain/cart_service.dart';
import 'package:TeaShopApp/src/features/orders/domain/user_orders_service.dart';
import 'package:TeaShopApp/src/features/profile/domain/models/profile_hive_model.dart';
import 'package:TeaShopApp/src/features/profile/domain/profile_service.dart';
import 'package:TeaShopApp/src/ui/screens/profile_verification/profile_verification_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'auth_service.dart';

class AuthBus {
  final AuthService _authService;
  final ProfileService _profileService;
  final UserOrdersService _userOrdersService;
  final CartService _cartService;

  AuthBus(
    this._authService,
    this._profileService,
    this._userOrdersService,
    this._cartService,
  );

  ProfileHiveModel _profileHiveModel = ProfileHiveModel.empty();

  Future<void> initProfileAfterLogin(BuildContext context, String email) async {
    int profileId = 0;

    await _profileService
        .saveProfile(email)
        .then(
          (value) async => {
            await setProfileModel(),
            await authDone(),
            goToVerifyRoute(context),
          },
        )
        .then(
          (value) async => {
            profileId = await _profileService.getProfileId(),
            await saveCart(profileId),
          },
        );
  }

  Future<void> clearStorageAfterLogout() async {
    await _cartService.clearCartInStorage();
    await _profileService.clearProfileInfo();
    await _userOrdersService.clearOrders();
  }

  Future<void> setProfileModel() async => _profileHiveModel = await _profileService.getProfile();

  Future<void> saveCart(int profileId) async {
    if (profileId != 0) {
      await _cartService.saveCart(profileId);
    }
  }

  Future<void> authDone() async {
    if (_profileHiveModel.isVerified) {
      await _authService.authDone();
    }
  }

  void goToVerifyRoute(BuildContext context) {
    if (!_profileHiveModel.isVerified && context.mounted) {
      context.pushNamed(ProfileVerificationRoute.pageName);
    }
  }
}

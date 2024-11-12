import 'package:TeaShopApp/src/features/auth/domain/auth_service.dart';
import 'package:TeaShopApp/src/features/orders/domain/user_orders_service.dart';
import 'package:TeaShopApp/src/features/profile/domain/profile_service.dart';

class UserOrdersBus {
  final AuthService _authService;
  final ProfileService _profileService;
  final UserOrdersService _userOrdersService;

  UserOrdersBus(
    this._authService,
    this._profileService,
    this._userOrdersService,
  );

  Future<bool> initUserOrders() async {
    final profileId = await _profileService.getProfileId();
    final isLoggedIn = await _authService.getProfileLogging();

    if (profileId > 0 && isLoggedIn) {
      await _userOrdersService.saveUserOrders(profileId);

      return true;
    } else {
      return false;
    }
  }
}

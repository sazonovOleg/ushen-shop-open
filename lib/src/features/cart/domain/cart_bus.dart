import 'package:TeaShopApp/src/features/auth/domain/auth_service.dart';
import 'package:TeaShopApp/src/features/cart/domain/cart_service.dart';
import 'package:TeaShopApp/src/features/cart/domain/models/cart_model.dart';
import 'package:TeaShopApp/src/features/profile/domain/profile_service.dart';
import 'package:flutter/cupertino.dart';

class CartBus {
  final AuthService _authService;
  final CartService _cartService;
  final ProfileService _profileService;

  CartBus(
    this._authService,
    this._cartService,
    this._profileService,
  );

  Future<bool> initCart() async {
    final isLogin = await _authService.getProfileLogging();

    if (isLogin) {
      final profileId = await _profileService.getProfileId();
      await _cartService.saveCart(profileId);

      return true;
    } else {
      return false;
    }
  }

  Future<void> reSaveCart(List<CartModel> listCartModel) async {
    final profileId = await _profileService.getProfileId();

    await _cartService
        .reSaveCart(listCartModel)
        .then((value) async => await _cartService.addCartToBackend(profileId));
  }

  Future<void> clearCart() async {
    final profileId = await _profileService.getProfileId();

    if (profileId != 0) {
      await _cartService.clearCartOnBackend(profileId);
    } else {
      await _cartService.clearCartInStorage();
    }
  }

  Future<void> addCartToBackend() async {
    final int profileId = await _profileService.getProfileId();

    if (profileId == 0) return;

    await _cartService.addCartToBackend(profileId);
  }
}

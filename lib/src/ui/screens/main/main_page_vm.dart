import 'dart:async';

import 'package:TeaShopApp/src/features/cart/domain/cart_service.dart';
import 'package:TeaShopApp/src/ui/common/error_handler.dart';
import 'package:TeaShopApp/src/ui/screens/about/about_page_route.dart';
import 'package:TeaShopApp/src/ui/screens/cart/cart_page_route.dart';
import 'package:TeaShopApp/src/ui/screens/profile/profile_page_route.dart';
import 'package:TeaShopApp/src/ui/screens/shop/shop_page_route.dart';
import 'package:TeaShopApp/src/ui/screens/user_orders/user_order_route.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainPageVM extends ChangeNotifier with ErrorHandler {
  final Widget widget;
  final CartService _cartService;

  MainPageVM(
    this._cartService, {
    required this.widget,
  });

  StreamSubscription? _streamSubscription;

  int quantity = 0;

  Future<void> init(Widget widget) async {
    try {
      await _cartService.getCartGoodsLength();

      _streamSubscription = _cartService.cartGoodsState.listen(
        (lengthState) async {
          quantity = lengthState;
          notifyListeners();
        },
      );
    } on Exception catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      handleError(e.toString());
    }

    widget = widget;
  }

  int calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    if (location.contains(ShopPageRoute.route)) {
      return 0;
    }
    if (location.contains(CartPageRoute.route)) {
      return 1;
    }
    if (location.contains(ProfilePageRoute.route)) {
      return 2;
    }
    if (location.contains(UserOrdersRoute.route)) {
      return 3;
    }
    if (location.contains(AboutPageRoute.route)) {
      return 4;
    }

    return 0;
  }

  Future<void> onItemTapped(
    int index,
    BuildContext context,
  ) async {
    switch (index) {
      case 0:
        return context.go(
          ShopPageRoute.route,
        );
      case 1:
        return context.go(
          CartPageRoute.route,
        );
      case 2:
        return context.go(
          ProfilePageRoute.route,
        );
      case 3:
        return context.go(
          UserOrdersRoute.route,
        );
      case 4:
        return context.go(
          AboutPageRoute.route,
        );
      default:
        return context.go(
          ShopPageRoute.route,
        );
    }
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}

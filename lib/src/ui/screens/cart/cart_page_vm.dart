import 'package:TeaShopApp/src/features/auth/domain/auth_service.dart';
import 'package:TeaShopApp/src/features/cart/domain/cart_bus.dart';
import 'package:TeaShopApp/src/features/cart/domain/cart_service.dart';
import 'package:TeaShopApp/src/features/cart/domain/models/cart_model.dart';
import 'package:TeaShopApp/src/features/orders/domain/user_orders_service.dart';
import 'package:TeaShopApp/src/ui/common/error_handler.dart';
import 'package:TeaShopApp/src/ui/screens/order/order_page_route.dart';
import 'package:TeaShopApp/src/ui/screens/profile/profile_page_route.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CartPageVM extends ChangeNotifier with ErrorHandler {
  final CartService _cartService;
  final CartBus _cartBus;
  final UserOrdersService _userOrdersService;
  final AuthService _authService;

  CartPageVM(
    this._cartService,
    this._userOrdersService,
    this._cartBus,
    this._authService,
  );

  List<CartModel> cartList = [];
  List<CartModel> nCartList = [];

  bool isLoading = false;
  bool isAnimation = false;
  bool startInitCart = false;
  bool isLogin = false;

  int sum = 0;

  Future<void> init() async {
    _loading();

    try {
      await getCart();
      isLogin = await _authService.getProfileLogging();

      if (sum != 0) {
        await _userOrdersService.saveTotalSum(sum);
      }
    } on Exception catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      handleError(e.toString());
    }

    _loading();
    notifyListeners();
  }

  //TODO: Need refactoring
  Future<void> getCart() async {
    startInitCart = true;

    await _cartBus.initCart().then(
          (value) async => {
            cartList = await _cartService.getCart(),
            cartList.isNotEmpty ? totalSum() : null,
          },
        );
  }

  void _loading() {
    isLoading = !isLoading;
  }

  Future<void> removeItem(int itemKey) async {
    if (cartList.length == 1) {
      clearCart();
    } else {
      cartList.removeAt(itemKey);
      notifyListeners();

      await _cartBus
          .reSaveCart(cartList)
          .then((value) async => {cartList = await _cartService.getCart()});

      notifyListeners();
    }
  }

  void totalSum() {
    List<int> priceList = [];

    for (var element in cartList) {
      priceList.add(element.price);
    }

    sum = priceList.reduce((value, element) => value + element);

    notifyListeners();
  }

  Future<void> clearCart() async {
    isAnimation = true;
    notifyListeners();

    cartList.clear();
    await _cartBus.clearCart();

    Future.delayed(const Duration(milliseconds: 2400), () {
      isAnimation = false;
      notifyListeners();
    });
  }

  void goToOrder(BuildContext context) {
    context.goNamed(OrderPageRoute.pageName);
  }

  void goToProfile(BuildContext context) {
    context.goNamed(ProfilePageRoute.pageName);
  }
}

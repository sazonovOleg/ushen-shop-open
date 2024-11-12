import 'package:TeaShopApp/src/features/cart/domain/cart_bus.dart';
import 'package:TeaShopApp/src/features/orders/domain/models/user_orders_model.dart';
import 'package:TeaShopApp/src/features/orders/domain/user_orders_service.dart';
import 'package:TeaShopApp/src/features/profile/domain/profile_service.dart';
import 'package:TeaShopApp/src/ui/common/error_handler.dart';
import 'package:TeaShopApp/src/ui/screens/shop/shop_page_route.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrderPageVM extends ChangeNotifier with ErrorHandler {
  final UserOrdersService _userOrdersService;
  final ProfileService _profileService;
  final CartBus _cartBus;

  OrderPageVM(
    this._userOrdersService,
    this._profileService,
    this._cartBus,
  );

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController postcodeController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  bool isValidateName = false;
  bool isValidateAddress = false;
  bool isValidatePostcode = false;
  bool isLoading = true;
  bool isOrderCreated = false;

  int totalSum = 0;
  int _profileId = 0;

  String delivery = 'Почта России';

  Future<void> init() async {
    try {
      totalSum = await _userOrdersService.getTotalSum();
      _profileId = await _profileService.getProfileId();
    } on Exception catch (e) {
      handleError(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }

  void validateName(String value) {
    if (value.length >= 2) {
      isValidateName = true;
      notifyListeners();
    } else {
      isValidateName = false;
      notifyListeners();
    }
  }

  void validateAddress(String value) {
    if (value.length > 6) {
      isValidateAddress = true;
      notifyListeners();
    } else {
      isValidateAddress = false;
      notifyListeners();
    }
  }

  void validatePostcode(String value) {
    bool isPostCode = RegExp(r'^[0-9]').hasMatch(value);

    if (value.length == 6 && isPostCode) {
      isValidatePostcode = true;
      notifyListeners();
    } else {
      isValidatePostcode = false;
      notifyListeners();
    }
  }

  bool disabledBtn() {
    if (isValidateName && isValidateAddress && isValidatePostcode) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> createOrder() async {
    try {
      if (isValidateName && isValidateAddress && isValidatePostcode) {
        await _userOrdersService
            .createOrder(
              _profileId,
              UserOrdersModelForResponse(
                delivery: delivery,
                userName: nameController.text,
                address: addressController.text,
                postcode: postcodeController.text,
                commentForOrder: commentController.text,
              ),
            )
            .then(
              (value) async => await _cartBus.clearCart(),
            );

        isOrderCreated = true;
        notifyListeners();
      }
    } on Exception catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      handleError(e.toString());

      notifyListeners();
    }
  }

  void goToShopPage(BuildContext context) => context.pushReplacementNamed(ShopPageRoute.pageName);
}

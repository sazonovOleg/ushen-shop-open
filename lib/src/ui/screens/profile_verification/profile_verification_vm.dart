import 'package:TeaShopApp/src/features/auth/domain/auth_bus.dart';
import 'package:TeaShopApp/src/features/auth/domain/auth_service.dart';
import 'package:TeaShopApp/src/ui/common/error_handler.dart';
import 'package:TeaShopApp/src/ui/screens/profile/profile_page_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileVerificationVM extends ChangeNotifier with ErrorHandler {
  final AuthService _authService;
  final AuthBus _authBus;

  ProfileVerificationVM(
    this._authService,
    this._authBus,
  );

  TextEditingController verifyController = TextEditingController();
  bool isVerify = false;
  bool isLoading = false;

  void init() {}

  void validateVerify(String value) {
    if (value.length == 8) {
      isVerify = true;
      notifyListeners();
    } else {
      isVerify = false;
      notifyListeners();
    }
  }

  Future<void> sendToken(BuildContext context) async {
    try {
      await _authService
          .verifyProfile(verifyController.text)
          .then((email) async => await initProfileAndPushRoute(email, context));
    } on DioError catch (e) {
      handleError(e.message);

      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> initProfileAndPushRoute(String email, BuildContext context) async {
    if (email.isEmpty) return;

    await _authBus.initProfileAfterLogin(context, email).then((value) => pushProfileRoute(context));
  }

  void pushProfileRoute(BuildContext context) {
    context.pushReplacementNamed(
      ProfilePageRoute.pageName,
    );
  }
}

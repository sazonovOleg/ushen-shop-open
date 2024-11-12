import 'package:TeaShopApp/src/features/auth/domain/auth_service.dart';
import 'package:TeaShopApp/src/ui/common/error_handler.dart';
import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class RecoveryPassVM extends ChangeNotifier with ErrorHandler {
  final AuthService _authService;

  RecoveryPassVM(
    this._authService,
  );

  TextEditingController emailController = TextEditingController();
  bool isValidateEmail = false;
  bool isLoading = false;

  void init() {}

  Future<void> resetPass() async {
    try {
      await _authService.resetPass(emailController.text);
    } on DioError catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);

      handleError(e.message);

      isLoading = false;
      notifyListeners();
    }
  }

  void validateEmail(String value) {
    bool isEmail =
        RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$').hasMatch(value);

    if (isEmail) {
      isValidateEmail = true;
      notifyListeners();
    } else {
      isValidateEmail = false;
      notifyListeners();
    }
  }
}

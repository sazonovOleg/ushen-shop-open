import 'dart:async';

import 'package:TeaShopApp/src/features/auth/domain/auth_service.dart';
import 'package:TeaShopApp/src/ui/common/error_handler.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class ProfilePageVM extends ChangeNotifier with ErrorHandler {
  final AuthService _authService;

  ProfilePageVM(
    this._authService,
  );

  StreamSubscription? _streamSubscription;

  bool isLoading = true;
  bool isLogin = false;

  Future<void> init() async {
    try {
      await _authService.checkAuthState();

      _streamSubscription = _authService.authState.listen((authState) async {
        isLogin = authState;
        isLoading = false;
        notifyListeners();
      });
    } on Exception catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      handleError(e.toString());
    }
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}

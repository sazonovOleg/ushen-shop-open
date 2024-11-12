import 'dart:io';

import 'package:TeaShopApp/src/constants/assets_const.dart';
import 'package:TeaShopApp/src/features/tea/domain/tea_service.dart';
import 'package:TeaShopApp/src/infrastructure/firebase/firebase_analytics.dart';
import 'package:TeaShopApp/src/infrastructure/shared_pref/shared_pref.dart';
import 'package:TeaShopApp/src/ui/common/error_handler.dart';
import 'package:TeaShopApp/src/ui/common/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppVm extends ChangeNotifier with ErrorHandler {
  final MainTheme _mainTheme;
  final SharedPref _sharedPref;
  final TeaService _teaService;
  final FirebaseAnalyticsProxy _firebaseAnalyticsProxy;

  ThemeData? theme;

  AppVm(
    this._mainTheme,
    this._sharedPref,
    this._teaService,
    this._firebaseAnalyticsProxy,
  );

  void init() async {
    initTheme();

    await _certificateVerification();
    await _sharedPref.init();
    await _teaService.clearSubCategoryTeaList();
    _firebaseAnalyticsProxy.logAppOpen();
  }

  Future<void> _certificateVerification() async {
    final data = await PlatformAssetBundle().load(AssetsConst.certPath);
    SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
  }

  void initTheme () {
    const themeBrightness = Brightness.light;

    theme = _mainTheme.themeData(themeBrightness);
  }
}

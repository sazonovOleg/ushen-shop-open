import 'package:TeaShopApp/src/features/tea/domain/models/all_tea_hive_model.dart';
import 'package:TeaShopApp/src/features/tea/domain/tea_service.dart';
import 'package:TeaShopApp/src/infrastructure/firebase/firebase_analytics.dart';
import 'package:TeaShopApp/src/ui/common/error_handler.dart';
import 'package:TeaShopApp/src/ui/screens/shop/shop_page_route.dart';
import 'package:TeaShopApp/src/ui/screens/shop_product/shop_product_route.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShopPageVM extends ChangeNotifier with ErrorHandler {
  final TeaService _service;
  final FirebaseAnalyticsProxy _analytics;

  ShopPageVM(
    this._service,
    this._analytics,
  );

  List<AllTeaModel> allTeaList = [];
  List<TeaModel> teaList = [];

  bool isLoading = true;
  bool isBackBtn = false;

  String type = '';

  Future<void> init(
    BuildContext context,
    String type,
    String subtype,
  ) async {
    _analytics.logOpenShop();

    try {
      await _service.initAllTypeOfTea();

      if (context.mounted) {
        await initTea(
          context,
          type,
          subtype,
        );

        setBackBtn(context);
      }
    } on Exception catch (error, stackTrace) {
      FirebaseCrashlytics.instance.recordError(error, stackTrace);
      handleError(error.toString());
    }

    _setLoading();
  }

  Future<void> initTea(
    BuildContext context,
    String type,
    String subtype,
  ) async {
    if (type != '') {
      await _service.initSortTypeOfTea(type, subtype);
      teaList = await _service.getSubCategoryTeaList();

      teaList.isEmpty ? allTeaList = await _service.getCategoryTeaList() : null;
    } else {
      allTeaList = await _service.getAllTypeOfTea();
    }

    notifyListeners();
  }

  Future<void> goToPage(
    BuildContext context,
    String type,
    String subtype,
  ) async {
    if (!context.mounted) {
      return;
    }

    if (subtype != '' && subtype != type) {
      context.pushNamed(
        ShopPageRouteV2.pageName,
        extra: {
          'teaType': type,
          'teaSubtype': subtype,
        },
      );
    } else {
      context.pushNamed(
        ShopPageRouteV2.pageName,
        extra: {
          'teaType': type,
          'teaSubtype': '',
        },
      );
    }

    notifyListeners();
  }

  void goToShopProductPage(BuildContext context, int id) {
    context.pushNamed(
      ShopProductRoute.pageName,
      extra: {
        'teaId': id,
      },
    );
  }

  void _setLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<void> onBackPressed(BuildContext context) async {
    await _service.clearSubCategoryTeaList();

    if (context.mounted) context.pop();
  }

  void setBackBtn(BuildContext context) {
    isBackBtn = GoRouterState.of(context).matchedLocation.contains(ShopPageRouteV2.route);
  }
}

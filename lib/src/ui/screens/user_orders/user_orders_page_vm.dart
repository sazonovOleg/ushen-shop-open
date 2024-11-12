import 'package:TeaShopApp/src/features/orders/domain/models/user_orders_model.dart';
import 'package:TeaShopApp/src/features/orders/domain/user_orders_bus.dart';
import 'package:TeaShopApp/src/features/orders/domain/user_orders_service.dart';
import 'package:TeaShopApp/src/ui/common/error_handler.dart';
import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

enum OrderStatusEnum {
  created,
  inProgress,
  sent,
  done,
}

class UserOrdersPageVM extends ChangeNotifier with ErrorHandler {
  final UserOrdersService _userOrdersService;
  final UserOrdersBus _userOrdersBus;

  UserOrdersPageVM(
    this._userOrdersService,
    this._userOrdersBus,
  );

  List<UserOrdersModel> ordersList = [];

  bool isLoading = false;

  Future<void> init() async {
    isLoading = true;

    await getOrders();

    isLoading = false;
    notifyListeners();
  }

  Future<void> getOrders() async {
    try {
      await _userOrdersBus.initUserOrders().then((value) async => await setOrderList(value));
    } on DioError catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      handleError(e.toString());
    }
  }

  Future<void> setOrderList(bool listNotEmpty) async {
    if (!listNotEmpty) return;

    await _userOrdersService.getUserOrders().then((value) => ordersList = value);
  }

  MaterialColor setStatusColor(String statusText) {
    final status = OrderStatusEnum.values.firstWhere(
      (element) => element.name == statusText,
      orElse: () => OrderStatusEnum.created,
    );

    switch (status) {
      case OrderStatusEnum.created:
        return Colors.grey;
      case OrderStatusEnum.inProgress:
        return Colors.yellow;
      case OrderStatusEnum.sent:
        return Colors.red;
      case OrderStatusEnum.done:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String translateStatus(String statusText) {
    final status = OrderStatusEnum.values.firstWhere(
      (element) => element.name == statusText,
      orElse: () => OrderStatusEnum.created,
    );

    switch (status) {
      case OrderStatusEnum.created:
        return 'Создан';
      case OrderStatusEnum.inProgress:
        return 'В сборке';
      case OrderStatusEnum.sent:
        return 'Отправлено';
      case OrderStatusEnum.done:
        return 'Доставлено';
      default:
        return 'Создан';
    }
  }
}

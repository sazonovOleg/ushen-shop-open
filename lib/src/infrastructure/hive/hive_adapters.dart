import 'package:TeaShopApp/src/features/cart/data/models/hive/cart_hive_model.dart';
import 'package:TeaShopApp/src/features/orders/data/models/hive/user_orders_hive_model.dart';
import 'package:TeaShopApp/src/features/profile/domain/models/profile_hive_model.dart';
import 'package:TeaShopApp/src/features/tea/domain/models/all_tea_hive_model.dart';
import 'package:hive_flutter/adapters.dart';

class RegisterHive {
  void registerHiveAdapters() {
    Hive
      ..registerAdapter(AllTeaModelAdapter())
      ..registerAdapter(TeaModelAdapter())
      ..registerAdapter(ProfileHiveModelAdapter())
      ..registerAdapter(UserOrdersHiveModelAdapter())
      ..registerAdapter(OrdersGoodsHiveModelAdapter())
      ..registerAdapter(CartHiveModelAdapter());
  }
}

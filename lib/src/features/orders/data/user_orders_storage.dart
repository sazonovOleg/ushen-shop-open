import 'package:TeaShopApp/src/infrastructure/hive/hive_storage.dart';
import 'package:TeaShopApp/src/infrastructure/shared_pref/shared_pref.dart';

import 'models/hive/user_orders_hive_model.dart';

class UserOrdersStorage {
  final HiveStorage _hiveStorage;
  final SharedPref _sharedPref;

  UserOrdersStorage(
    this._hiveStorage,
    this._sharedPref,
  );

  final String _ordersKey = 'user_orders_key';
  final String _totalSumKey = 'total_sum_key';
  final String _totalCountKey = 'total_count_key';

  Future<void> saveOrders(List<UserOrdersHiveModel> list) async {
    await _hiveStorage.saveBox(_ordersKey, list);
  }

  Future<List<UserOrdersHiveModel>> getOrders() async {
    final orders = await _hiveStorage.getBox(_ordersKey);

    return orders ?? [];
  }

  Future<void> clearOrders() async {
    _hiveStorage.clearBox(_ordersKey);
  }

  Future<void> saveTotalSum(int value) async {
    await _sharedPref.setInt(_totalSumKey, value);
  }

  Future<int?> getTotalSum() async {
    return await _sharedPref.getInt(_totalSumKey);
  }

  Future<void> saveTotalCount(int value) async {
    await _sharedPref.setInt(_totalCountKey, value);
  }

  Future<int?> getTotalCount() async {
    return await _sharedPref.getInt(_totalCountKey);
  }
}

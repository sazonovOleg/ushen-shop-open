import 'package:TeaShopApp/src/features/orders/data/api/user_orders_api.dart';
import 'package:TeaShopApp/src/features/orders/data/user_orders_storage.dart';

import 'models/hive/user_orders_hive_model.dart';
import 'models/resp/user_orders_resp_model.dart';

class UserOrdersRepo {
  final UserOrdersApi _api;
  final UserOrdersStorage _storage;

  UserOrdersRepo(
    this._api,
    this._storage,
  );

  Future<void> createOrder(UserOrdersModelResponse data) async {
    await _api.createOrder(data);
  }

  Future<void> saveOrders(int userId) async {
    final response = await _api.getOrders(userId);

    final list = response
        .map(
          (e) => UserOrdersHiveModel(
            id: e.id!,
            userId: e.userId,
            date: e.date,
            goods: e.goods
                .map(
                  (el) => OrdersGoodsHiveModel(
                    name: el.name,
                    weight: el.weight,
                    price: el.price.toString(),
                  ),
                )
                .toList(),
            totalSum: e.totalSum,
            status: e.status,
          ),
        )
        .toList();

    await _storage.saveOrders(list);
  }

  Future<List<UserOrdersHiveModel>> getOrders() async {
    final orders = await _storage.getOrders();

    return orders;
  }

  Future<void> clearOrders() async {
    await _storage.clearOrders();
  }

  Future<void> saveTotalSum(int value) async {
    await _storage.saveTotalSum(value);
  }

  Future<int> getTotalSum() async {
    final sum = await _storage.getTotalSum();
    return sum ?? 0;
  }

  Future<void> saveTotalCount(int value) async {
    await _storage.saveTotalSum(value);
  }

  Future<int?> getTotalCount() async {
    final count =  await _storage.getTotalCount();

    return count ?? 0;
  }
}

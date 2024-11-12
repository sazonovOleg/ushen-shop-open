import 'package:hive_flutter/adapters.dart';

part 'user_orders_hive_model.g.dart';

@HiveType(typeId: 4)
class UserOrdersHiveModel {
  UserOrdersHiveModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.goods,
    required this.totalSum,
    required this.status,
  });

  @HiveField(0, defaultValue: 0)
  final int id;
  @HiveField(1, defaultValue: 0)
  final int userId;
  @HiveField(2, defaultValue: '')
  final String date;
  @HiveField(3, defaultValue: [])
  final List<OrdersGoodsHiveModel> goods;
  @HiveField(4, defaultValue: '')
  final String totalSum;
  @HiveField(5, defaultValue: '')
  final String status;
}

@HiveType(typeId: 5)
class OrdersGoodsHiveModel {
  OrdersGoodsHiveModel({
    required this.name,
    required this.weight,
    required this.price,
  });

  @HiveField(0, defaultValue: '')
  final String name;
  @HiveField(1, defaultValue: '')
  final String weight;
  @HiveField(2, defaultValue: '')
  final String price;
}

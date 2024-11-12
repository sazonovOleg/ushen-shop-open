import 'package:hive_flutter/adapters.dart';

part 'cart_hive_model.g.dart';

@HiveType(typeId: 6)
class CartHiveModel {
  CartHiveModel({
    required this.name,
    required this.weight,
    required this.price,
    required this.image,
    required this.indexEl,
    required this.wholePack,
  });

  @HiveField(0, defaultValue: '')
  final String name;
  @HiveField(1, defaultValue: 0)
  final int weight;
  @HiveField(2, defaultValue: 0)
  final int price;
  @HiveField(3, defaultValue: '')
  final String image;
  @HiveField(4, defaultValue: 0)
  final int indexEl;
  @HiveField(5, defaultValue: false)
  final bool wholePack;
}
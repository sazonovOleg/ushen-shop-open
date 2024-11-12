import 'package:hive_flutter/adapters.dart';

part 'all_tea_hive_model.g.dart';

@HiveType(typeId: 1)
class AllTeaModel {
  AllTeaModel({
    required this.id,
    required this.name,
    required this.img,
    required this.type,
    required this.subtype,
  });

  @HiveField(0, defaultValue: 0)
  final int id;
  @HiveField(1, defaultValue: '')
  final String name;
  @HiveField(2, defaultValue: '')
  final String img;
  @HiveField(3, defaultValue: '')
  final String type;
  @HiveField(4, defaultValue: '')
  final String subtype;
}

@HiveType(typeId: 2)
class TeaModel {
  TeaModel({
    required this.id,
    required this.name,
    required this.price,
    required this.fullPrice,
    required this.weight,
    required this.description,
    required this.type,
    required this.subtype,
    required this.quantity,
    required this.saleQuantity,
    required this.full,
    required this.images,
  });

  @HiveField(0, defaultValue: 0)
  final int id;
  @HiveField(1, defaultValue: '')
  final String name;
  @HiveField(2, defaultValue: 0)
  final double price;
  @HiveField(3, defaultValue: 0)
  final double fullPrice;
  @HiveField(4, defaultValue: '')
  final String weight;
  @HiveField(5, defaultValue: [])
  final List<String> description;
  @HiveField(6, defaultValue: '')
  final String type;
  @HiveField(7, defaultValue: '')
  final String subtype;
  @HiveField(8, defaultValue: 0)
  final double quantity;
  @HiveField(9, defaultValue: 0)
  final double saleQuantity;
  @HiveField(10, defaultValue: false)
  final bool full;
  @HiveField(11, defaultValue: [])
  final List<String> images;

  TeaModel.empty()
      : id = 0,
        name = '',
        price = 0,
        fullPrice = 0,
        weight = '',
        description = [],
        type = '',
        subtype = '',
        quantity = 0,
        saleQuantity = 0,
        full = false,
        images = [];
}

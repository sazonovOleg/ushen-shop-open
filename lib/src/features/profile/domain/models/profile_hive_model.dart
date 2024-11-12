import 'package:hive_flutter/adapters.dart';

part 'profile_hive_model.g.dart';

@HiveType(typeId: 3)
class ProfileHiveModel {
  ProfileHiveModel({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.isVerified,
    required this.discount,
    required this.totalPurchaseAmount,
  });

  @HiveField(0, defaultValue: 0)
  final int id;
  @HiveField(1, defaultValue: '')
  final String name;
  @HiveField(2, defaultValue: '')
  final String lastName;
  @HiveField(3, defaultValue: '')
  final String email;
  @HiveField(4, defaultValue: '')
  final String phone;
  @HiveField(5, defaultValue: false)
  final bool isVerified;
  @HiveField(6, defaultValue: '0')
  final String discount;
  @HiveField(7, defaultValue: '0')
  final String totalPurchaseAmount;

  ProfileHiveModel.empty()
      : id = 0,
        name = '',
        lastName = '',
        email = '',
        phone = '',
        isVerified = false,
        discount = '',
        totalPurchaseAmount = '';
}
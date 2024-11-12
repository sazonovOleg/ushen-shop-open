import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'user_orders_resp_model.g.dart';

List<UserOrdersModelResponse> userOrdersResponseFromJson(List<dynamic> data) =>
    List<UserOrdersModelResponse>.from(
      data.map(
        (x) => _$UserOrdersModelResponseFromJson(x as Map<String, dynamic>),
      ),
    );

String userOrdersResponseToJson(UserOrdersModelResponse data) =>
    json.encode(_$UserOrdersModelResponseToJson(data));

@JsonSerializable(includeIfNull: false)
class UserOrdersModelResponse {
  UserOrdersModelResponse({
    required this.id,
    required this.userId,
    required this.date,
    required this.goods,
    required this.delivery,
    required this.userName,
    required this.address,
    required this.postcode,
    required this.commentForOrder,
    required this.totalSum,
    required this.totalCount,
    required this.status,
    required this.received,
  });

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'userId')
  final int userId;
  @JsonKey(name: 'date')
  final String date;
  @JsonKey(name: 'goods')
  final List<OrdersGoodsResponse> goods;
  @JsonKey(name: 'delivery')
  final String delivery;
  @JsonKey(name: 'userName')
  final String userName;
  @JsonKey(name: 'address')
  final String address;
  @JsonKey(name: 'postcode')
  final String postcode;
  @JsonKey(name: 'commentForOrder')
  final String commentForOrder;
  @JsonKey(name: 'totalSum')
  final String totalSum;
  @JsonKey(name: 'totalCount')
  final String totalCount;
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'received')
  final bool received;
}

@JsonSerializable()
class OrdersGoodsResponse {
  OrdersGoodsResponse({
    required this.name,
    required this.weight,
    required this.price,
  });

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'weight')
  final String weight;
  @JsonKey(name: 'price')
  final int price;

  factory OrdersGoodsResponse.fromJson(Map<String, dynamic> json) =>
      _$OrdersGoodsResponseFromJson(json);
}

String orderGoodsResponseToJson(List<OrdersGoodsResponse> data) =>
    json.encode(List<dynamic>.from(data.map(_$OrdersGoodsResponseToJson)));
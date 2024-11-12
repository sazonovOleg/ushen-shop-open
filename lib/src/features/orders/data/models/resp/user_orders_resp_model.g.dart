// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_orders_resp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserOrdersModelResponse _$UserOrdersModelResponseFromJson(
        Map<String, dynamic> json) =>
    UserOrdersModelResponse(
      id: json['id'] as int?,
      userId: json['userId'] as int,
      date: json['date'] as String,
      goods: (json['goods'] as List<dynamic>)
          .map((e) => OrdersGoodsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      delivery: json['delivery'] as String,
      userName: json['userName'] as String,
      address: json['address'] as String,
      postcode: json['postcode'] as String,
      commentForOrder: json['commentForOrder'] as String,
      totalSum: json['totalSum'] as String,
      totalCount: json['totalCount'] as String,
      status: json['status'] as String,
      received: json['received'] as bool,
    );

Map<String, dynamic> _$UserOrdersModelResponseToJson(
    UserOrdersModelResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['userId'] = instance.userId;
  val['date'] = instance.date;
  val['goods'] = instance.goods;
  val['delivery'] = instance.delivery;
  val['userName'] = instance.userName;
  val['address'] = instance.address;
  val['postcode'] = instance.postcode;
  val['commentForOrder'] = instance.commentForOrder;
  val['totalSum'] = instance.totalSum;
  val['totalCount'] = instance.totalCount;
  val['status'] = instance.status;
  val['received'] = instance.received;
  return val;
}

OrdersGoodsResponse _$OrdersGoodsResponseFromJson(Map<String, dynamic> json) =>
    OrdersGoodsResponse(
      name: json['name'] as String,
      weight: json['weight'] as String,
      price: json['price'] as int,
    );

Map<String, dynamic> _$OrdersGoodsResponseToJson(
        OrdersGoodsResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'weight': instance.weight,
      'price': instance.price,
    };

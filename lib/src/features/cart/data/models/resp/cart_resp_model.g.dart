// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_resp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartModelResponse _$CartModelResponseFromJson(Map<String, dynamic> json) =>
    CartModelResponse(
      name: json['name'] as String,
      weight: json['weight'] as int,
      price: json['price'] as int,
      image: json['image'] as String,
      indexEl: json['indexEl'] as int,
      wholePack: json['wholePack'] as bool,
    );

Map<String, dynamic> _$CartModelResponseToJson(CartModelResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'weight': instance.weight,
      'price': instance.price,
      'image': instance.image,
      'indexEl': instance.indexEl,
      'wholePack': instance.wholePack,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tea_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeaModelResponse _$TeaModelResponseFromJson(Map<String, dynamic> json) =>
    TeaModelResponse(
      id: json['id'] as int,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      fullPrice: (json['fullPrice'] as num).toDouble(),
      weight: json['weight'] as String,
      description: (json['description'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      type: json['type'] as String,
      subtype: json['subtype'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      saleQuantity: (json['saleQuantity'] as num).toDouble(),
      full: json['full'] as bool,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$TeaModelResponseToJson(TeaModelResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'fullPrice': instance.fullPrice,
      'weight': instance.weight,
      'description': instance.description,
      'type': instance.type,
      'subtype': instance.subtype,
      'quantity': instance.quantity,
      'saleQuantity': instance.saleQuantity,
      'full': instance.full,
      'images': instance.images,
    };

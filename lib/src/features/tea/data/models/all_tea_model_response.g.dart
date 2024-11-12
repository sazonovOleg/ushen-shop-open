// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_tea_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllTeaModelResponse _$AllTeaModelResponseFromJson(Map<String, dynamic> json) =>
    AllTeaModelResponse(
      id: json['id'] as int,
      name: json['name'] as String,
      img: json['img'] as String,
      type: json['type'] as String,
      subtype: json['subtype'] as String?,
    );

Map<String, dynamic> _$AllTeaModelResponseToJson(AllTeaModelResponse instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'img': instance.img,
    'type': instance.type,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('subtype', instance.subtype);
  return val;
}

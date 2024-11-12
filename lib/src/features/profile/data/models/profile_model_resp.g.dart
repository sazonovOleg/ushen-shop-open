// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModelResponse _$ProfileModelResponseFromJson(
        Map<String, dynamic> json) =>
    ProfileModelResponse(
      id: json['id'] as int,
      name: json['name'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      password: json['password'] as String,
      isVerified: json['isVerified'] as bool,
      discount: json['discount'] as int,
      totalPurchaseAmount: json['totalPurchaseAmount'] as int,
      emailToken: json['emailToken'] as String,
    );

Map<String, dynamic> _$ProfileModelResponseToJson(
        ProfileModelResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lastName': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
      'isVerified': instance.isVerified,
      'discount': instance.discount,
      'totalPurchaseAmount': instance.totalPurchaseAmount,
      'emailToken': instance.emailToken,
    };

import 'package:json_annotation/json_annotation.dart';

part 'profile_model_resp.g.dart';

ProfileModelResponse profileResponseFromJson(Map<String, dynamic> data) =>
    _$ProfileModelResponseFromJson(data);

@JsonSerializable()
class ProfileModelResponse {
  ProfileModelResponse({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
    required this.isVerified,
    required this.discount,
    required this.totalPurchaseAmount,
    required this.emailToken,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'lastName')
  final String lastName;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'phone')
  final String phone;
  @JsonKey(name: 'password')
  final String password;
  @JsonKey(name: 'isVerified')
  final bool isVerified;
  @JsonKey(name: 'discount')
  final int discount;
  @JsonKey(name: 'totalPurchaseAmount')
  final int totalPurchaseAmount;
  @JsonKey(name: 'emailToken')
  final String emailToken;
}

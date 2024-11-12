import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'cart_resp_model.g.dart';

List<CartModelResponse> cartModelResponseFromJson(List<dynamic> data) =>
    List<CartModelResponse>.from(
      data.map(
        (x) => _$CartModelResponseFromJson(x as Map<String, dynamic>),
      ),
    );

String cartModelResponseToJson(List<CartModelResponse> data) =>
    json.encode(List<dynamic>.from(data.map(_$CartModelResponseToJson)));

@JsonSerializable()
class CartModelResponse {
  CartModelResponse({
    required this.name,
    required this.weight,
    required this.price,
    required this.image,
    required this.indexEl,
    required this.wholePack,
  });

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'weight')
  final int weight;
  @JsonKey(name: 'price')
  final int price;
  @JsonKey(name: 'image')
  final String image;
  @JsonKey(name: 'indexEl')
  final int indexEl;
  @JsonKey(name: 'wholePack')
  final bool wholePack;
}

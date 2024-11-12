import 'package:json_annotation/json_annotation.dart';

part 'tea_model_response.g.dart';

List<TeaModelResponse> teaResponseFromJson(List<dynamic> data) =>
    List<TeaModelResponse>.from(
      data.map(
        (x) => _$TeaModelResponseFromJson(x as Map<String, dynamic>),
      ),
    );

@JsonSerializable()
class TeaModelResponse {
  TeaModelResponse({
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

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'price')
  final double price;
  @JsonKey(name: 'fullPrice')
  final double fullPrice;
  @JsonKey(name: 'weight')
  final String weight;
  @JsonKey(name: 'description')
  final List<String> description;
  @JsonKey(name: 'type')
  final String type;
  @JsonKey(name: 'subtype')
  final String subtype;
  @JsonKey(name: 'quantity')
  final double quantity;
  @JsonKey(name: 'saleQuantity')
  final double saleQuantity;
  @JsonKey(name: 'full')
  final bool full;
  @JsonKey(name: 'images')
  final List<String> images;
}

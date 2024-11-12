import 'package:json_annotation/json_annotation.dart';

part 'all_tea_model_response.g.dart';

List<AllTeaModelResponse> allTeaResponseFromJson(List<dynamic> data) =>
    List<AllTeaModelResponse>.from(
      data.map(
        (x) => _$AllTeaModelResponseFromJson(x as Map<String, dynamic>),
      ),
    );

@JsonSerializable(includeIfNull: false)
class AllTeaModelResponse {
  AllTeaModelResponse({
    required this.id,
    required this.name,
    required this.img,
    required this.type,
    this.subtype,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'img')
  final String img;
  @JsonKey(name: 'type')
  final String type;
  @JsonKey(name: 'subtype')
  final String? subtype;
}

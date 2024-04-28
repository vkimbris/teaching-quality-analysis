import 'package:json_annotation/json_annotation.dart';

part 'category_dto.g.dart';

@JsonSerializable()
class CategoryDTO {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'score')
  final double score;

  CategoryDTO({
    required this.name,
    required this.score,
  });

  factory CategoryDTO.fromJson(Map<String, dynamic> json) =>
      _$CategoryDTOFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryDTOToJson(this);
}

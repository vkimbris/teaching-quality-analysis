import 'package:json_annotation/json_annotation.dart';

part 'marks_dto.g.dart';

@JsonSerializable()
class MarksDTO {
  @JsonKey(name: 'value')
  final double value;

  @JsonKey(name: 'category')
  final String category;

  MarksDTO({
    required this.value,
    required this.category,
  });

  factory MarksDTO.fromJson(Map<String, dynamic> json) =>
      _$MarksDTOFromJson(json);
  Map<String, dynamic> toJson() => _$MarksDTOToJson(this);
}

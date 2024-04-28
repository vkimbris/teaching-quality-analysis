import 'package:json_annotation/json_annotation.dart';

part 'stats_dto.g.dart';

@JsonSerializable()
class StatsDTO {
  @JsonKey(name: 'value')
  final int value;

  @JsonKey(name: 'category')
  final String category;

  StatsDTO({
    required this.value,
    required this.category,
  });

  factory StatsDTO.fromJson(Map<String, dynamic> json) =>
      _$StatsDTOFromJson(json);
  Map<String, dynamic> toJson() => _$StatsDTOToJson(this);
}

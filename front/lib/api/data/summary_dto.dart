import 'package:json_annotation/json_annotation.dart';

part 'summary_dto.g.dart';

@JsonSerializable()
class SummaryDTO {
  @JsonKey(name: 'summary')
  final String summary;

  SummaryDTO({
    required this.summary,
  });

  factory SummaryDTO.fromJson(Map<String, dynamic> json) =>
      _$SummaryDTOFromJson(json);
  Map<String, dynamic> toJson() => _$SummaryDTOToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
import 'package:xakaton/api/data/marks_dto.dart';
import 'package:xakaton/api/data/stats_dto.dart';

part 'statisctics_dto.g.dart';

@JsonSerializable()
class StatisticsDTO {
  @JsonKey(name: 'counts')
  final List<StatsDTO> stats;

  @JsonKey(name: 'marks')
  final List<MarksDTO> marks;

  StatisticsDTO({
    required this.stats,
    required this.marks,
  });

  factory StatisticsDTO.fromJson(Map<String, dynamic> json) =>
      _$StatisticsDTOFromJson(json);
  Map<String, dynamic> toJson() => _$StatisticsDTOToJson(this);
}

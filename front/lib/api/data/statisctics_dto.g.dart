// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statisctics_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticsDTO _$StatisticsDTOFromJson(Map<String, dynamic> json) =>
    StatisticsDTO(
      stats: (json['counts'] as List<dynamic>)
          .map((e) => StatsDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      marks: (json['marks'] as List<dynamic>)
          .map((e) => MarksDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StatisticsDTOToJson(StatisticsDTO instance) =>
    <String, dynamic>{
      'counts': instance.stats,
      'marks': instance.marks,
    };

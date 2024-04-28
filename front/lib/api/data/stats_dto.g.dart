// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatsDTO _$StatsDTOFromJson(Map<String, dynamic> json) => StatsDTO(
      value: (json['value'] as num).toInt(),
      category: json['category'] as String,
    );

Map<String, dynamic> _$StatsDTOToJson(StatsDTO instance) => <String, dynamic>{
      'value': instance.value,
      'category': instance.category,
    };

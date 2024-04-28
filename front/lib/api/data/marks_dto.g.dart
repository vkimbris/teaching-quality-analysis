// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marks_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarksDTO _$MarksDTOFromJson(Map<String, dynamic> json) => MarksDTO(
      value: (json['value'] as num).toDouble(),
      category: json['category'] as String,
    );

Map<String, dynamic> _$MarksDTOToJson(MarksDTO instance) => <String, dynamic>{
      'value': instance.value,
      'category': instance.category,
    };

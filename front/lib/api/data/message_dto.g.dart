// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageDTO _$MessageDTOFromJson(Map<String, dynamic> json) => MessageDTO(
      date: json['date'] as String?,
      lessonID: json['lesson_id'] as String?,
      role: (json['role'] as num?)?.toInt(),
      text: json['text'] as String?,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => CategoryDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MessageDTOToJson(MessageDTO instance) =>
    <String, dynamic>{
      'lesson_id': instance.lessonID,
      'role': instance.role,
      'text': instance.text,
      'date': instance.date,
      'categories': instance.categories,
    };

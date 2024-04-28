import 'package:json_annotation/json_annotation.dart';

part 'lesson_dto.g.dart';

@JsonSerializable()
class LessonDTO {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'startDate')
  final String startDate;

  LessonDTO({
    required this.id,
    required this.startDate,
  });

  factory LessonDTO.fromJson(Map<String, dynamic> json) =>
      _$LessonDTOFromJson(json);
  Map<String, dynamic> toJson() => _$LessonDTOToJson(this);
}

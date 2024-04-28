import 'package:json_annotation/json_annotation.dart';
import 'package:xakaton/api/data/category_dto.dart';

part 'message_dto.g.dart';

@JsonSerializable()
class MessageDTO {
  @JsonKey(name: 'lesson_id')
  final String? lessonID;

  @JsonKey(name: 'role')
  final int? role;

  @JsonKey(name: 'text')
  final String? text;

  @JsonKey(name: 'date')
  final String? date;

  @JsonKey(name: 'categories')
  final List<CategoryDTO> categories;

  MessageDTO({
    required this.date,
    required this.lessonID,
    required this.role,
    required this.text,
    required this.categories,
  });

  @override
  String toString() {
    return 'Structure{date:$date, lessonID:$lessonID}';
  }

  factory MessageDTO.fromJson(Map<String, dynamic> json) =>
      _$MessageDTOFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDTOToJson(this);
}

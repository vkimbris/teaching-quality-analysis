import 'package:xakaton/api/data/message_dto.dart';
import 'package:xakaton/core/util/app_utils.dart';
import 'package:xakaton/features/main/domain/entity/category.dart';

class Message {
  final int lessonID;
  final bool isAdmin;
  final String text;
  final DateTime date;
  final List<Category> categories;

  Message({
    required this.categories,
    required this.lessonID,
    required this.isAdmin,
    required this.text,
    required this.date,
  });

  static Message? fromMessageDTO(MessageDTO dto) {
    if (dto.role == null ||
        dto.text == null ||
        dto.lessonID == null ||
        dto.date == null) {
      return null;
    }
    return Message(
      date: AppUtils.fromStringDateTime(dto.date!, true),
      isAdmin: dto.role == 1,
      lessonID: int.parse(dto.lessonID!),
      text: dto.text!,
      categories:
          dto.categories.map((e) => Category.fromCategoryDTO(e)).toList(),
    );
  }

  static MessageDTO toMessageDTO(Message msg) {
    return MessageDTO(
      date: msg.date.toString(),
      lessonID: msg.lessonID.toString(),
      role: msg.isAdmin ? 1 : 0,
      text: msg.text,
      categories: msg.categories.map((e) => Category.toCategoryDTO(e)).toList(),
    );
  }
}

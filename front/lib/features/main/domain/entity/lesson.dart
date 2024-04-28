import 'package:xakaton/api/data/lesson_dto.dart';
import 'package:xakaton/core/util/app_utils.dart';

class Lesson {
  final int id;
  final DateTime dateStart;

  const Lesson({
    required this.id,
    required this.dateStart,
  });

  static Lesson fromLessonDTO(LessonDTO dto) {
    return Lesson(
      dateStart: AppUtils.fromStringDateTime(dto.startDate),
      id: int.parse(dto.id),
    );
  }
}

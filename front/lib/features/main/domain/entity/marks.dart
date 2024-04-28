import 'package:xakaton/api/data/marks_dto.dart';

class Marks {
  final String category;
  final double value;

  Marks({
    required this.category,
    required this.value,
  });

  static Marks fromMarksDTO(MarksDTO dto) {
    return Marks(category: dto.category, value: dto.value);
  }
}

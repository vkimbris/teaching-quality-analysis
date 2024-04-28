import 'package:xakaton/api/data/summary_dto.dart';

class SummaryEntity {
  final String text;

  SummaryEntity({
    required this.text,
  });

  static SummaryEntity fromSummaryDTO(SummaryDTO dto) {
    return SummaryEntity(text: dto.summary);
  }
}

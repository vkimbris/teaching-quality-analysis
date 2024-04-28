import 'package:xakaton/api/data/message_dto.dart';
import 'package:xakaton/api/data/statisctics_dto.dart';
import 'package:xakaton/api/data/summary_dto.dart';

/// Repository interface for working with places.
abstract class IMlRepository {
  Future<List<MessageDTO>> getMessages({required int lessonId});

  Future<StatisticsDTO> getStats({required List<MessageDTO> msgDto});

  Future<SummaryDTO> getSummary({required List<MessageDTO> msgDto});
}

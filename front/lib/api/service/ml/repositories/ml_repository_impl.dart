import 'package:xakaton/api/data/message_dto.dart';
import 'package:xakaton/api/data/statisctics_dto.dart';
import 'package:xakaton/api/data/summary_dto.dart';
import 'package:xakaton/api/service/ml/client/ml_api.dart';
import 'package:xakaton/api/service/ml/repositories/base/ml_repository_interface.dart';

/// Repository interface for working with places.
class MlRepositoryImpl implements IMlRepository {
  final MlApi _mlApi;

  MlRepositoryImpl(this._mlApi);

  @override
  Future<List<MessageDTO>> getMessages({required int lessonId}) async {
    return await _mlApi.getMessages(lessonId);
  }

  @override
  Future<StatisticsDTO> getStats({required List<MessageDTO> msgDto}) async {
    return await _mlApi.stats(msgDto);
  }

  @override
  Future<SummaryDTO> getSummary({required List<MessageDTO> msgDto}) async {
    return await _mlApi.explainMessages(msgDto);
  }
}

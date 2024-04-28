import 'package:xakaton/api/service/ml/repositories/base/ml_repository_interface.dart';
import 'package:xakaton/features/main/domain/entity/message.dart';
import 'package:xakaton/features/main/domain/entity/statistics.dart';
import 'package:xakaton/features/main/domain/entity/summary.dart';

class MlApiInteractor {
  final IMlRepository _mlApiRepository;

  MlApiInteractor(this._mlApiRepository);

  /// Get [Place] by it's [id].
  Future<List<Message>> getMessages(int id) async {
    final messagesDto = await _mlApiRepository.getMessages(lessonId: id);
    var messages = <Message>[];

    for (final msg in messagesDto) {
      //print(msg.toString());
      final converted = Message.fromMessageDTO(msg);
      if (converted != null) {
        messages.add(converted);
      }
    }
    return messages;
  }

  Future<Statistics> getStats(List<Message> messages) async {
    final response = await _mlApiRepository.getStats(
        msgDto: messages.map((e) => Message.toMessageDTO(e)).toList());
    return Statistics.fromStatisticsDTO(response);
  }

  Future<SummaryEntity> getSummary(List<Message> messages) async {
    final response = await _mlApiRepository.getSummary(
        msgDto: messages.map((e) => Message.toMessageDTO(e)).toList());
    return SummaryEntity.fromSummaryDTO(response);
  }
}

import 'package:elementary/elementary.dart';
import 'package:xakaton/features/main/domain/entity/message.dart';
import 'package:xakaton/features/main/domain/entity/statistics.dart';
import 'package:xakaton/features/main/domain/entity/summary.dart';
import 'package:xakaton/features/main/interactors/ml_api_interactor.dart';

/// Default Elementary model for LessonAnalyze module
class LessonAnalyzeScreenModel extends ElementaryModel {
  final MlApiInteractor mlApiInteractor;

  Future<List<Message>> getMessages(int id) async {
    return await mlApiInteractor.getMessages(id);
  }

  Future<Statistics> getStats(List<Message> msgs) async {
    return await mlApiInteractor.getStats(msgs);
  }

  Future<SummaryEntity> getSummary(List<Message> msgs) async {
    return await mlApiInteractor.getSummary(msgs);
  }

  LessonAnalyzeScreenModel(this.mlApiInteractor) : super();
}

import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xakaton/features/lesson_analyze/screens/lesson_analyze_screen.dart';
import 'package:xakaton/features/lesson_analyze/screens/lesson_analyze_screen_model.dart';
import 'package:xakaton/features/main/di/base/main_scope_interface.dart';
import 'package:xakaton/features/main/domain/entity/lesson.dart';
import 'package:xakaton/features/main/domain/entity/message.dart';
import 'package:xakaton/features/main/domain/entity/statistics.dart';
import 'package:xakaton/features/main/domain/entity/summary.dart';

LessonAnalyzeScreenWidgetModel defaultLessonAnalyzeScreenWidgetModelFactory(
    BuildContext context, Lesson lesson) {
  final model = LessonAnalyzeScreenModel(
      Provider.of<IMainScope>(context).mlApiInteractor);
  return LessonAnalyzeScreenWidgetModel(model, context, lesson: lesson);
}

/// Default widget model for LessonAnalyzeScreenWidget
class LessonAnalyzeScreenWidgetModel
    extends WidgetModel<LessonAnalyzeScreen, LessonAnalyzeScreenModel>
    implements ILessonAnalyzeScreenWidgetModel {
  final Lesson lesson;
  final BuildContext _ctx;

  final _messagesListState = EntityStateNotifier<List<Message>>(null);

  final _statsState = EntityStateNotifier<Statistics>(null);
  final _summaryEntityState = EntityStateNotifier<SummaryEntity>(null);

  LessonAnalyzeScreenWidgetModel(super.model, this._ctx,
      {required this.lesson});
  late final ScrollController _chatScrollController;
  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _chatScrollController = ScrollController();
  }

  @override
  void dispose() {
    _chatScrollController.dispose();
    super.dispose();
  }

  @override
  BuildContext get ctx => _ctx;

  @override
  ScrollController get chatScrollController => _chatScrollController;

  @override
  List<Message> get msgs => <Message>[];

  @override
  Lesson get lessonData => lesson;

  @override
  ValueListenable<EntityState<List<Message>>> get messagesListState =>
      _messagesListState;

  @override
  Future<void> onAnalyzePressed() async {
    final previousData = _messagesListState.value.data;

    _messagesListState.loading();
    _statsState.loading();
    _summaryEntityState.loading();

    try {
      final msgResponse = await model.getMessages(lesson.id);
      _messagesListState.content(msgResponse);

      final statsResponse = await model.getStats(msgResponse);
      statsResponse.stats.sort(
        (a, b) => a.category.compareTo(b.category),
      );

      _statsState.content(statsResponse);

      final summaryResponse = await model.getSummary(msgResponse);
      _summaryEntityState.content(summaryResponse);
    } on Exception catch (e) {
      _messagesListState.error(e, previousData);
    }
  }

  @override
  ValueListenable<EntityState<Statistics>> get statsState => _statsState;

  @override
  ValueListenable<EntityState<SummaryEntity>> get summaryEntityState =>
      _summaryEntityState;
}

abstract class ILessonAnalyzeScreenWidgetModel implements IWidgetModel {
  BuildContext get ctx;

  ScrollController get chatScrollController;

  List<Message> get msgs;

  Lesson get lessonData;

  ValueListenable<EntityState<List<Message>>> get messagesListState;

  ValueListenable<EntityState<Statistics>> get statsState;

  ValueListenable<EntityState<SummaryEntity>> get summaryEntityState;

  Future<void> onAnalyzePressed();
}

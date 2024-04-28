import 'package:flutter/material.dart';
import 'package:xakaton/features/lesson_analyze/screens/lesson_analyze_screen.dart';
import 'package:xakaton/features/main/domain/entity/lesson.dart';

/// [MaterialPageRoute] for [MainScreen].
class LessonAnalyzeScreenRoute extends MaterialPageRoute<void> {
  /// Create an instance of [MainScreen].
  LessonAnalyzeScreenRoute(Lesson lesson)
      : super(builder: (ctx) => LessonAnalyzeScreen(lesson: lesson));
}

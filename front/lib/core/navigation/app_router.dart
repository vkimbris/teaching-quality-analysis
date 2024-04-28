import 'package:flutter/material.dart';
import 'package:xakaton/features/lesson_analyze/route/main_screen_route.dart';
import 'package:xakaton/features/main/domain/entity/lesson.dart';
import 'package:xakaton/features/main/route/main_screen_route.dart';

/// All routes of the app.
class AppRouter {
  /// Path to MainScreen.
  static const String mainScreen = '/';

  /// Path to LessonAnalyzeScreen.
  static const String lessonAnalyzeScreen = '/lessonanalyze';

  /// List of routes.
  static final Map<String, Route Function(Object?)> routes = {
    mainScreen: (_) => MainScreenRoute(),
    lessonAnalyzeScreen: (settings) =>
        LessonAnalyzeScreenRoute(settings as Lesson)
  };
}

import 'package:dio/dio.dart';
import 'package:xakaton/api/data/lesson_dto.dart';

/// Repository interface for working with places.
abstract class IDatabaseRepository {
  Future<List<LessonDTO>> getLessons();

  Future<void> uploadFile(FormData data);
}

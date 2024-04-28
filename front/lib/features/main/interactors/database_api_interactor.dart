import 'package:dio/dio.dart';
import 'package:xakaton/api/service/database/repositories/base/database_repository_interface.dart';
import 'package:xakaton/features/main/domain/entity/lesson.dart';

class DatabaseApiInteractor {
  final IDatabaseRepository _databaseApiRepository;

  DatabaseApiInteractor(this._databaseApiRepository);

  Future<List<Lesson>> getLessons() async {
    final lessons = await _databaseApiRepository.getLessons();
    return lessons.map((e) => Lesson.fromLessonDTO(e)).toList();
  }

  Future<void> uploadFile(FormData data) async {
    return await _databaseApiRepository.uploadFile(data);
  }
}

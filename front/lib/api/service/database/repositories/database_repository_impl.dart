import 'package:dio/dio.dart';
import 'package:xakaton/api/data/lesson_dto.dart';
import 'package:xakaton/api/service/database/client/database_api.dart';
import 'package:xakaton/api/service/database/repositories/base/database_repository_interface.dart';

/// Repository interface for working with places.
class DatabaseRepositoryImpl implements IDatabaseRepository {
  final DatabaseApi _databaseApi;

  DatabaseRepositoryImpl(this._databaseApi);

  @override
  Future<List<LessonDTO>> getLessons() async {
    return await _databaseApi.getLessons();
  }

  @override
  Future<void> uploadFile(FormData data) async {
    return await _databaseApi.uploadFile(data);
  }
}

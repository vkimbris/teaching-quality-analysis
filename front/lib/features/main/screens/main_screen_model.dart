import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:xakaton/features/main/domain/entity/lesson.dart';
import 'package:xakaton/features/main/interactors/database_api_interactor.dart';

/// Default Elementary model for MainScreen module
class MainScreenModel extends ElementaryModel {
  final DatabaseApiInteractor databaseApiInteractor;

  Future<List<Lesson>> getLessons() async {
    return await databaseApiInteractor.getLessons();
  }

  Future<void> uploadFile(FormData data) async {
    return await databaseApiInteractor.uploadFile(data);
  }

  MainScreenModel(this.databaseApiInteractor) : super();
}

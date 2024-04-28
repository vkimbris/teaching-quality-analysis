import 'package:dio/dio.dart';
import 'package:xakaton/api/service/database/repositories/base/database_repository_interface.dart';
import 'package:xakaton/api/service/ml/repositories/base/ml_repository_interface.dart';
import 'package:xakaton/features/main/interactors/database_api_interactor.dart';
import 'package:xakaton/features/main/interactors/ml_api_interactor.dart';

/// Scope interface for [Main].
abstract class IMainScope {
  Dio get databaseDio;
  Dio get mlDio;

  /// Repository to work with places.
  IDatabaseRepository get databaseApiRepository;

  /// Interactor to work with places.
  DatabaseApiInteractor get databaseApiInteractor;

  /// Repository to work with places.
  IMlRepository get mlApiRepository;

  /// Interactor to work with places.
  MlApiInteractor get mlApiInteractor;
}

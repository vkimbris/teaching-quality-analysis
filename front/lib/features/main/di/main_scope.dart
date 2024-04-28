import 'package:dio/dio.dart';
import 'package:xakaton/api/service/database/client/database_api.dart';
import 'package:xakaton/api/service/database/repositories/base/database_repository_interface.dart';
import 'package:xakaton/api/service/database/repositories/database_repository_impl.dart';
import 'package:xakaton/api/service/ml/client/ml_api.dart';
import 'package:xakaton/api/service/ml/repositories/base/ml_repository_interface.dart';
import 'package:xakaton/api/service/ml/repositories/ml_repository_impl.dart';
import 'package:xakaton/config/database_api_urls.dart';
import 'package:xakaton/config/ml_api_urls.dart';
import 'package:xakaton/core/dio/dio_service.dart';
import 'package:xakaton/features/main/di/base/main_scope_interface.dart';
import 'package:xakaton/features/main/interactors/database_api_interactor.dart';
import 'package:xakaton/features/main/interactors/ml_api_interactor.dart';

/// Scope for [Main].
class MainScope implements IMainScope {
  late final Dio _databaseDio;
  late final IDatabaseRepository _databaseApiRepository;
  late final DatabaseApiInteractor _databaseApiInteractor;

  late final Dio _mlDio;
  late final IMlRepository _mlApiRepository;
  late final MlApiInteractor _mlApiInteractor;

  MainScope() {
    final databaseDio = DioModule().dio;
    final databaseApiClient =
        DatabaseApi(databaseDio, baseUrl: DatabaseApiUrls.url);
    _databaseApiRepository = DatabaseRepositoryImpl(databaseApiClient);
    _databaseApiInteractor = DatabaseApiInteractor(_databaseApiRepository);
    final mlDio = DioModule().dio;
    final mlApiClient = MlApi(mlDio, baseUrl: MlApiUrls.url);
    _mlApiRepository = MlRepositoryImpl(mlApiClient);
    _mlApiInteractor = MlApiInteractor(_mlApiRepository);
  }

  @override
  Dio get databaseDio => _databaseDio;

  @override
  DatabaseApiInteractor get databaseApiInteractor => _databaseApiInteractor;

  @override
  IDatabaseRepository get databaseApiRepository => _databaseApiRepository;

  @override
  Dio get mlDio => _mlDio;

  @override
  MlApiInteractor get mlApiInteractor => _mlApiInteractor;

  @override
  IMlRepository get mlApiRepository => _mlApiRepository;
}

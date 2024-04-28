import 'package:dio/dio.dart';
import 'package:xakaton/core/dio/interceptors/dio_error_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// Class - module for [Dio] configuration.
class DioModule {
  /// [Dio] instance.
  final dio = Dio()
    ..options = BaseOptions()
    ..interceptors.addAll(
      [
        DioErrorInterceptor(),
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        )
      ],
    );
}

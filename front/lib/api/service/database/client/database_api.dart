import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:xakaton/api/data/lesson_dto.dart';
import 'package:xakaton/config/database_api_urls.dart';

part 'database_api.g.dart';

/// ExampleApi gateway
@RestApi()
abstract class DatabaseApi {
  /// Creates ExampleApi gateway
  factory DatabaseApi(Dio dio, {String baseUrl}) = _DatabaseApi;

  @POST(DatabaseApiUrls.uploadFile)
  Future<void> uploadFile(
    @Body() FormData data,
  );

  @GET(DatabaseApiUrls.getLessons)
  Future<List<LessonDTO>> getLessons();
}

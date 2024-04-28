import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:xakaton/api/data/message_dto.dart';
import 'package:xakaton/api/data/statisctics_dto.dart';
import 'package:xakaton/api/data/summary_dto.dart';
import 'package:xakaton/config/ml_api_urls.dart';

part 'ml_api.g.dart';

/// ExampleApi gateway
@RestApi()
abstract class MlApi {
  /// Creates ExampleApi gateway
  factory MlApi(Dio dio, {String baseUrl}) = _MlApi;

  @POST(MlApiUrls.classifyMessages)
  Future<List<MessageDTO>> getMessages(
    @Query('lesson_id') int lessonId,
  );

  @POST(MlApiUrls.stats)
  Future<StatisticsDTO> stats(
    @Body() List<MessageDTO> messages,
  );

  @POST(MlApiUrls.explainMessages)
  Future<SummaryDTO> explainMessages(
    @Body() List<MessageDTO> messages,
  );
}

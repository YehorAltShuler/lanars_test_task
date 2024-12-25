import 'package:dio/dio.dart';
import 'package:lanars_test_task/core/DTOs/pexels_response.dart';
import 'package:retrofit/retrofit.dart';

import 'abstract/feeds_service.dart';

part 'pexels_service.g.dart';

@RestApi(baseUrl: "https://api.pexels.com/v1/")
abstract class PexelsService implements FeedsService {
  factory PexelsService(Dio dio, {String baseUrl}) = _PexelsService;

  @override
  @GET("/curated")
  Future<PexelsResponse> getFeeds({
    @Header('Authorization')
    String apiKey = 'ZmX2v0pZfw2iUiw894HgaKyaumDDobwdkbaNAQmOnCN63hoyGmrR0L8A',
    @Query("per_page") int perPage = 50,
    @Query("page") int page = 1,
  });
}

import '../../DTOs/pexels_response.dart';

abstract interface class FeedsService {
  Future<PexelsResponse> getFeeds({
    String apiKey,
    int perPage,
    int page,
  });
}

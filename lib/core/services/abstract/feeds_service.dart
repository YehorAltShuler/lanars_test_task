import 'package:retrofit/retrofit.dart';

import '../../DTO/pexels_response.dart';

abstract interface class FeedsService {
  Future<HttpResponse<PexelsResponse>> getFeeds({
    int perPage,
    int page,
  });
}

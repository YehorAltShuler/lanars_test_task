import 'package:lanars_test_task/core/services/abstract/feeds_service.dart';

import '../viewModel/feed.dart';

class FeedsRepository {
  final FeedsService _feedsService;

  FeedsRepository(this._feedsService);

  Future<List<Feed>> getFeeds(int page) async {
    try {
      final result = await _feedsService.getFeeds(page: page);
      return result.feeds;
    } catch (e) {
      rethrow;
    }
  }
}

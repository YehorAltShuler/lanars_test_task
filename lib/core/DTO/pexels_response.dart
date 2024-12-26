import '../../features/home/viewModel/feed.dart';

class PexelsResponse {
  final int page;
  final int perPage;
  final List<Feed> feeds;
  final String? nextPage;

  PexelsResponse({
    required this.page,
    required this.perPage,
    required this.feeds,
    this.nextPage,
  });

  factory PexelsResponse.fromMap(Map<String, dynamic> map) {
    return PexelsResponse(
      page: map['page'] as int,
      perPage: map['per_page'] as int,
      feeds: (map['photos'] as List<dynamic>)
          .map((photo) => Feed.fromMap(photo as Map<String, dynamic>))
          .toList(),
      nextPage: map['next_page'] as String?,
    );
  }
}

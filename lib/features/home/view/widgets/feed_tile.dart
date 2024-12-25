import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../../viewModel/feed.dart';

class FeedTile extends StatelessWidget {
  const FeedTile({super.key, required this.feed});
  final Feed feed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border:
              Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () =>
                    _showFullScreenImage(context, feed.originalPictureUrl),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    height: 56,
                    width: 56,
                    imageUrl: feed.smallPictureUrl,
                    placeholder: (context, url) {
                      return Container(
                        color: feed.avgColorAsColor,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feed.photographerName,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    if (feed.alt.isNotEmpty)
                      Text(
                        feed.alt,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFullScreenImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: PhotoView(
            imageProvider: CachedNetworkImageProvider(imageUrl),
            backgroundDecoration: BoxDecoration(color: Colors.transparent),
            loadingBuilder: (context, event) {
              return Center(
                  child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onPrimary,
              ));
            },
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          ),
        );
      },
    );
  }
}

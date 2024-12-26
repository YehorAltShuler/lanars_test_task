import 'package:flutter/material.dart';

import '../../viewModel/feed.dart';
import 'feed_tile.dart';

class SearchFeedsList extends StatefulWidget {
  const SearchFeedsList({
    super.key,
    required this.feeds,
  });

  final List<Feed> feeds;

  @override
  State<SearchFeedsList> createState() => _SearchFeedsListState();
}

class _SearchFeedsListState extends State<SearchFeedsList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Инициализация AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Длительность анимации
    );

    // Анимация прозрачности
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Анимация масштаба (увеличение с 90% до 100%)
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    // Запуск анимации
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Scrollbar(
          thumbVisibility: true,
          child: ListView.builder(
            itemCount: widget.feeds.length,
            itemBuilder: (context, index) {
              return FeedTile(feed: widget.feeds[index]);
            },
          ),
        ),
      ),
    );
  }
}

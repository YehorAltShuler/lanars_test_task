import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../viewModel/bloc/feeds_bloc.dart';
import '../../viewModel/feed.dart';
import 'feed_tile.dart';
import 'letter_header.dart';

class FullFeedsList extends StatefulWidget {
  const FullFeedsList({
    super.key,
    required this.feeds,
  });

  final List<Feed> feeds;

  @override
  State<FullFeedsList> createState() => _FullFeedsListState();
}

class _FullFeedsListState extends State<FullFeedsList>
    with SingleTickerProviderStateMixin {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late List<Feed> _feeds;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _feeds = List.from(widget.feeds);

    // Инициализация анимации появления списка
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Запуск анимации после построения виджета
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void didUpdateWidget(covariant FullFeedsList oldWidget) {
    super.didUpdateWidget(oldWidget);

    final newFeeds = widget.feeds;

    // Добавление новых элементов
    for (int i = 0; i < newFeeds.length; i++) {
      if (i >= _feeds.length || _feeds[i] != newFeeds[i]) {
        _feeds.insert(i, newFeeds[i]);
        _listKey.currentState?.insertItem(
          i,
          duration: const Duration(milliseconds: 700),
        );
      }
    }

    // Удаление лишних элементов
    for (int i = _feeds.length - 1; i >= newFeeds.length; i--) {
      final removedFeed = _feeds.removeAt(i);
      _listKey.currentState?.removeItem(
          i,
          (context, animation) => _buildFadeAndScaleTransition(
                animation: animation,
                child: FeedTile(feed: removedFeed),
              ),
          duration: const Duration(milliseconds: 700));
    }
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
      child: RefreshIndicator(
        onRefresh: () async {
          final feedsBloc = context.read<FeedsBloc>();
          feedsBloc.add(FeedsRefresh());
          await feedsBloc.stream.firstWhere(
              (state) => state is FeedsGetSuccess || state is FeedsError);
        },
        child: Scrollbar(
          thumbVisibility: true,
          child: AnimatedList(
            key: _listKey,
            initialItemCount:
                _feeds.length + 1, // Учитываем элемент для пагинации
            itemBuilder: (context, index, animation) {
              if (index < _feeds.length) {
                final feed = _feeds[index];
                final String currentLetter =
                    feed.photographerName[0].toUpperCase();
                final String? previousLetter = index > 0
                    ? _feeds[index - 1].photographerName[0].toUpperCase()
                    : null;

                bool showLetter =
                    previousLetter == null || currentLetter != previousLetter;

                return _buildFadeAndScaleTransition(
                  animation: animation,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (showLetter)
                        LetterHeader(letter: currentLetter)
                      else
                        const SizedBox(width: 28),
                      Expanded(
                        child: FeedTile(feed: feed),
                      ),
                    ],
                  ),
                );
              } else {
                // Элемент для загрузки следующей страницы
                context.read<FeedsBloc>().add(FeedsLoadMore());
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFadeAndScaleTransition({
    required Animation<double> animation,
    required Widget child,
  }) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation.drive(
          Tween<double>(begin: 0.8, end: 1.0).chain(
            CurveTween(curve: Curves.easeIn),
          ),
        ),
        child: child,
      ),
    );
  }
}

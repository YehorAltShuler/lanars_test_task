import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars_test_task/features/home/view/widgets/app_drawer.dart';
import 'package:lanars_test_task/features/home/view/widgets/feed_tile.dart';
import 'package:lanars_test_task/features/home/viewModel/feed.dart';

import '../../viewModel/bloc/feeds_bloc.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<FeedsBloc>().add(FeedsGet());
    _searchController.addListener(() {
      context.read<FeedsBloc>().add(FeedsSearch(_searchController.text.trim()));
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        bottom: _isSearching
            ? PreferredSize(
                preferredSize: Size.fromHeight(1.0),
                child: Container(
                  color: Theme.of(context).colorScheme.outline,
                  height: 1.0,
                ),
              )
            : null,
        centerTitle: true,
        title: _isSearching
            ? TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search...",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
                autofocus: true,
              )
            : Text("List page"),
        leading: _isSearching
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    _isSearching = false;
                    _searchController.clear();
                  });
                },
              )
            : null,
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _searchController.clear();
                } else {
                  _isSearching = true;
                }
              });
            },
          ),
        ],
      ),
      body: BlocBuilder<FeedsBloc, FeedsState>(
        builder: (context, state) {
          if (state is FeedsInitial || state is FeedsLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is FeedsGetSuccess) {
            final feeds = state.feeds;

            // Условие для отображения полного списка, если query пуст
            if (_isSearching && _searchController.text.isEmpty) {
              return _FullFeedsList(feeds: feeds);
            }

            return _isSearching
                ? _SearchFeedsList(feeds: feeds)
                : _FullFeedsList(feeds: feeds);
          }

          if (state is FeedsLoadMoreSuccess) {
            final feeds = state.feeds;
            return _FullFeedsList(feeds: feeds);
          }

          return Center(
            child: Text('Something went wrong. Try again'),
          );
        },
      ),
    );
  }
}

class _FullFeedsList extends StatelessWidget {
  const _FullFeedsList({
    required this.feeds,
  });

  final List<Feed> feeds;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        final feedsBloc = context.read<FeedsBloc>();
        feedsBloc.add(FeedsRefresh());
        await feedsBloc.stream.firstWhere(
            (state) => state is FeedsGetSuccess || state is FeedsError);
      },
      child: Scrollbar(
        thumbVisibility: true,
        child: ListView.builder(
            itemCount: feeds.length + 1,
            itemBuilder: (context, index) {
              if (index < feeds.length) {
                // Обычный элемент списка
                final feed = feeds[index];
                final String currentLetter =
                    feed.photographerName[0].toUpperCase();
                final String? previousLetter = index > 0
                    ? feeds[index - 1].photographerName[0].toUpperCase()
                    : null;

                bool showLetter =
                    previousLetter == null || currentLetter != previousLetter;

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (showLetter)
                      Container(
                        alignment: Alignment.center,
                        width: 40,
                        child: Text(
                          currentLetter,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      )
                    else
                      SizedBox(width: 40),
                    Expanded(
                      child: FeedTile(feed: feed),
                    ),
                  ],
                );
              } else {
                // Последний элемент — индикатор загрузки
                context.read<FeedsBloc>().add(FeedsLoadMore());
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }),
      ),
    );
  }
}

class _SearchFeedsList extends StatelessWidget {
  const _SearchFeedsList({
    required this.feeds,
  });
  final List<Feed> feeds;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      child: ListView.builder(
        itemCount: feeds.length,
        itemBuilder: (context, index) {
          return FeedTile(feed: feeds[index]);
        },
      ),
    );
  }
}

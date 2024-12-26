import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars_test_task/core/common/widgets/app_drawer.dart';

import '../../viewModel/bloc/feeds_bloc.dart';
import '../widgets/full_feeds_list.dart';
import '../widgets/search_feeds_list.dart';

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
                child: Column(
                  children: [
                    Container(
                      color: Theme.of(context).colorScheme.outline,
                      height: 1.0,
                    ),
                    SizedBox(
                      height: 12,
                    )
                  ],
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
                    _searchController.clear();

                    _isSearching = false;
                    context.read<FeedsBloc>().add(FeedsGet());
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
      body: SafeArea(
        child: BlocBuilder<FeedsBloc, FeedsState>(
          builder: (context, state) {
            if (state is FeedsInitial || state is FeedsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is FeedsGetSuccess) {
              final feeds = state.feeds;
              if (_isSearching && _searchController.text.isEmpty) {
                return FullFeedsList(feeds: feeds);
              }
              return _isSearching
                  ? SearchFeedsList(feeds: feeds)
                  : FullFeedsList(feeds: feeds);
            }
            if (state is FeedsLoadMoreSuccess) {
              final feeds = state.feeds;
              return FullFeedsList(feeds: feeds);
            }

            return Center(
              child: Text('Something went wrong. Try again'),
            );
          },
        ),
      ),
    );
  }
}

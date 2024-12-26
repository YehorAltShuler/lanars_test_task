import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars_test_task/features/home/model/feeds_repository.dart';

import '../feed.dart';

part 'feeds_event.dart';
part 'feeds_state.dart';

class FeedsBloc extends Bloc<FeedsEvent, FeedsState> {
  final FeedsRepository _feedsRepository;
  List<Feed> allFeeds = [];
  List<Feed> filteredFeeds = [];
  ScrollController scrollController = ScrollController();
  int page = 1;
  bool isLoading = false;

  Timer? _debounce;

  FeedsBloc(this._feedsRepository) : super(FeedsInitial()) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        add(FeedsLoadMore());
      }
    });
    on<FeedsGet>(_onFeedsGet);
    on<FeedsLoadMore>(_onFeedsLoadMore);
    on<FeedsSearch>(_onFeedsSearch);
    on<FeedsRefresh>(_onFeedsRefresh);
  }

  void clearFilteredFeeds() {
    filteredFeeds.clear();
  }

  void _onFeedsGet(FeedsGet event, Emitter<FeedsState> emit) async {
    emit(FeedsLoading());
    page = 1;
    try {
      final feeds = await _feedsRepository.getFeeds(page: page);
      allFeeds = feeds;
      allFeeds.sort((a, b) => a.photographerName.compareTo(b.photographerName));
      emit(FeedsGetSuccess(allFeeds));
    } catch (e) {
      emit(FeedsError(e.toString()));
    }
  }

  void _onFeedsRefresh(FeedsRefresh event, Emitter<FeedsState> emit) async {
    try {
      page = 1;
      final feeds = await _feedsRepository.getFeeds(page: page);
      allFeeds = feeds;
      allFeeds.sort((a, b) => a.photographerName.compareTo(b.photographerName));
      emit(FeedsGetSuccess(allFeeds));
    } catch (e) {
      emit(FeedsError(e.toString()));
    }
  }

  void _onFeedsLoadMore(FeedsLoadMore event, Emitter<FeedsState> emit) async {
    isLoading = true;
    try {
      page++;
      final feeds = await _feedsRepository.getFeeds(page: page);
      allFeeds.addAll(feeds);
      allFeeds.sort((a, b) => a.photographerName.compareTo(b.photographerName));
      emit(FeedsLoadMoreSuccess(allFeeds));
      isLoading = false;
    } catch (e) {
      page--;
      emit(FeedsError(e.toString()));
    }
  }

  Future<void> _onFeedsSearch(
      FeedsSearch event, Emitter<FeedsState> emit) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    if (emit.isDone) return; // Нужно чтобы не срабатывала пагинация

    if (event.query.length >= 3) {
      emit(FeedsLoading());
      final query = event.query.toLowerCase();

      filteredFeeds = allFeeds
          .where(
              (feed) => feed.photographerName.toLowerCase().startsWith(query))
          .toList();

      emit(FeedsGetSuccess(filteredFeeds));
    } else if (event.query.isEmpty) {
      emit(FeedsGetSuccess(allFeeds));
    }
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    _debounce?.cancel();
    return super.close();
  }
}

part of 'feeds_bloc.dart';

@immutable
sealed class FeedsEvent {
  const FeedsEvent();
}

class FeedsGet extends FeedsEvent {}

class FeedsRefresh extends FeedsEvent {}

class FeedsLoadMore extends FeedsEvent {}

class FeedsSearch extends FeedsEvent {
  final String query;

  const FeedsSearch(this.query);
}

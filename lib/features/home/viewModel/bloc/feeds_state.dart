part of 'feeds_bloc.dart';

@immutable
sealed class FeedsState {
  const FeedsState();
}

final class FeedsInitial extends FeedsState {}

final class FeedsLoading extends FeedsState {}

final class FeedsGetSuccess extends FeedsState {
  final List<Feed> feeds;

  const FeedsGetSuccess(this.feeds);
}

final class FeedsLoadMoreSuccess extends FeedsState {
  final List<Feed> feeds;

  const FeedsLoadMoreSuccess(this.feeds);
}

final class FeedsError extends FeedsState {
  final String error;

  const FeedsError(this.error);
}

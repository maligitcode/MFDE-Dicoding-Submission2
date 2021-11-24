part of 'tv_watchlist_cubit.dart';

abstract class TVWatchlistState extends Equatable {
  const TVWatchlistState();

  @override
  List<Object> get props => [];
}

class TVWatchlistInitialState extends TVWatchlistState {
  const TVWatchlistInitialState();
}

class TVWatchlistLoadingState extends TVWatchlistState {
  const TVWatchlistLoadingState();
}

class TVWatchlistErrorState extends TVWatchlistState {
  const TVWatchlistErrorState(
    this.message,
  );

  final String message;

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => true;

  TVWatchlistErrorState copyWith({
    String? message,
  }) {
    return TVWatchlistErrorState(
      message ?? this.message,
    );
  }
}

class TVWatchlistLoadedState extends TVWatchlistState {
  const TVWatchlistLoadedState({
    required this.items,
  });

  final List<TV> items;

  @override
  List<Object> get props => [items];

  @override
  bool get stringify => true;

  TVWatchlistLoadedState copyWith({
    List<TV>? items,
  }) {
    return TVWatchlistLoadedState(
      items: items ?? this.items,
    );
  }
}

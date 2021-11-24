part of 'tv_now_playing_cubit.dart';

abstract class TVNowPlayingState extends Equatable {
  const TVNowPlayingState();
  @override
  List<Object> get props => [];
}

class TVNowPlayingInitialState extends TVNowPlayingState {
  const TVNowPlayingInitialState();
}

class TVNowPlayingLoadingState extends TVNowPlayingState {
  const TVNowPlayingLoadingState();
}

class TVNowPlayingErrorState extends TVNowPlayingState {
  const TVNowPlayingErrorState(
      this.message,
      );

  final String message;

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => true;

  TVNowPlayingErrorState copyWith({
    String? message,
  }) {
    return TVNowPlayingErrorState(
      message ?? this.message,
    );
  }
}

class TVNowPlayingLoadedState extends TVNowPlayingState {
  const TVNowPlayingLoadedState({
    required this.items,
  });

  final List<TV> items;

  @override
  List<Object> get props => [items];

  @override
  bool get stringify => true;

  TVNowPlayingLoadedState copyWith({
    List<TV>? items,
  }) {
    return TVNowPlayingLoadedState(
      items: items ?? this.items,
    );
  }
}

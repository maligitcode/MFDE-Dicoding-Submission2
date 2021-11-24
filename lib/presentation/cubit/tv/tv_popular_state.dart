part of 'tv_popular_cubit.dart';

abstract class TVPopularState extends Equatable {
  const TVPopularState();

  @override
  List<Object> get props => [];
}

class TVPopularInitialState extends TVPopularState {
  const TVPopularInitialState();
}

class TVPopularLoadingState extends TVPopularState {
  const TVPopularLoadingState();
}

class TVPopularErrorState extends TVPopularState {
  const TVPopularErrorState(
    this.message,
  );

  final String message;

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => true;

  TVPopularErrorState copyWith({
    String? message,
  }) {
    return TVPopularErrorState(
      message ?? this.message,
    );
  }
}

class TVPopularLoadedState extends TVPopularState {
  const TVPopularLoadedState({
    required this.items,
  });

  final List<TV> items;

  @override
  List<Object> get props => [items];

  @override
  bool get stringify => true;

  TVPopularLoadedState copyWith({
    List<TV>? items,
  }) {
    return TVPopularLoadedState(
      items: items ?? this.items,
    );
  }
}

part of 'tv_top_rated_cubit.dart';

abstract class TVTopRatedState extends Equatable {
  const TVTopRatedState();

  @override
  List<Object> get props => [];
}

class TVTopRatedInitialState extends TVTopRatedState {
  const TVTopRatedInitialState();
}

class TVTopRatedLoadingState extends TVTopRatedState {
  const TVTopRatedLoadingState();
}

class TVTopRatedErrorState extends TVTopRatedState {
  const TVTopRatedErrorState(
    this.message,
  );

  final String message;

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => true;

  TVTopRatedErrorState copyWith({
    String? message,
  }) {
    return TVTopRatedErrorState(
      message ?? this.message,
    );
  }
}

class TVTopRatedLoadedState extends TVTopRatedState {
  const TVTopRatedLoadedState({
    required this.items,
  });

  final List<TV> items;

  @override
  List<Object> get props => [items];

  @override
  bool get stringify => true;

  TVTopRatedLoadedState copyWith({
    List<TV>? items,
  }) {
    return TVTopRatedLoadedState(
      items: items ?? this.items,
    );
  }
}

part of 'tv_search_cubit.dart';

@immutable
abstract class TVSearchState extends Equatable {
  const TVSearchState();

  @override
  List<Object> get props => [];
}

class TVSearchInitial extends TVSearchState {
  const TVSearchInitial();
}

class TVSearhLoadingState extends TVSearchState {
  const TVSearhLoadingState();
}

class TVSearchErrorState extends TVSearchState {
  const TVSearchErrorState(this.message);

  @override
  List<Object> get props => [message];
  final String message;

  @override
  bool get stringify => true;

  TVSearchErrorState copyWith({
    String? message,
  }) {
    return TVSearchErrorState(message ?? this.message);
  }
}

class TVSearchLoadedState extends TVSearchState {
  const TVSearchLoadedState({
    required this.items,
  });

  final List<TV> items;

  @override
  List<Object> get props => [items];

  @override
  bool get stringify => true;

  TVSearchLoadedState copyWith({
    List<TV>? items,
  }) {
    return TVSearchLoadedState(
      items: items ?? this.items,
    );
  }
}

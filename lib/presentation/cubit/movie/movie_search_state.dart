part of 'movie_search_cubit.dart';

@immutable
abstract class MovieSearchState extends Equatable {
  const MovieSearchState();

  @override
  List<Object> get props => [];
}

class MovieSearchInitial extends MovieSearchState {
  const MovieSearchInitial();
}

class MovieSearhLoadingState extends MovieSearchState {
  const MovieSearhLoadingState();
}

class MovieSearchErrorState extends MovieSearchState {
  const MovieSearchErrorState(this.message);

  @override
  List<Object> get props => [message];
  final String message;

  @override
  bool get stringify => true;

  MovieSearchErrorState copyWith({
    String? message,
  }) {
    return MovieSearchErrorState(message ?? this.message);
  }
}

class MovieSearchLoadedState extends MovieSearchState {
  const MovieSearchLoadedState({
    required this.items,
  });

  final List<Movie> items;

  @override
  List<Object> get props => [items];

  @override
  bool get stringify => true;

  MovieSearchLoadedState copyWith({
    List<Movie>? items,
  }) {
    return MovieSearchLoadedState(
      items: items ?? this.items,
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'movie_search_state.dart';

class MovieSearchCubit extends Cubit<MovieSearchState> {
  MovieSearchCubit({
    required this.searchMovies,
  }) : super(const MovieSearchInitial());
  final SearchMovies searchMovies;
  Future<void> get(String query) async {
    emit(const MovieSearhLoadingState());
    final result = await searchMovies.execute(query);
    result.fold(
          (failure) => emit(
        MovieSearchErrorState(failure.message),
      ),
          (values) => emit(
        MovieSearchLoadedState(items: values),
      ),
    );
  }
}

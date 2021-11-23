import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'movie_search_state.dart';

class MovieSearchCubit extends Cubit<MovieSearchState> {
  MovieSearchCubit({required this.getSearchMovies})
      : super(MovieSearchInitial());
  final SearchMovies getSearchMovies;

  Future<void> get(String query) async {
    emit(const MovieSearhLoadingState());
    final result = await getSearchMovies.execute(query);
    result.fold((failure) => emit(MovieSearchErrorState(failure.message)),
        (values) => MovieSearchLoadedState(items: values));
  }
}


import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit({
    required this.getMovieDetail,
    required this.saveWatchlist,
    required this.removeWatchlist,
    required this.getWatchListStatus,
  }) : super(const MovieDetailState());

  final GetMovieDetail getMovieDetail;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetWatchListStatus getWatchListStatus;

  /// Message
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  Future<void> get(int id) async {
    emit(state.setRequestState(RequestState.Loading));
    final result = await getMovieDetail.execute(id);
    result.fold(
      (failure) {
        emit(state.setMessage(failure.message));
        emit(state.setRequestState(RequestState.Error));
      },
      (movie) {
        emit(state.setRequestState(RequestState.Loaded));
        emit(state.setMovie(movie));
      },
    );
  }

  Future<void> addWatchlist(MovieDetail movie) async {
    final result = await saveWatchlist.execute(movie);
    result.fold(
      (failure) => emit(state.setMessageWatchlist(failure.message)),
      (value) => emit(state.setMessageWatchlist(value)),
    );
    await getWatchlistStatus(movie.id);
  }

  Future<void> deleteWatchlist(MovieDetail movie) async {
    final result = await removeWatchlist.execute(movie);
    result.fold(
      (failure) => emit(state.setMessageWatchlist(failure.message)),
      (value) => emit(state.setMessageWatchlist(value)),
    );
    await getWatchlistStatus(movie.id);
  }

  Future<void> getWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    emit(state.setAddedToWatchlist(result));
  }
}

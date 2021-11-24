
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/tv/remove_watchlisttv.dart';
import 'package:ditonton/domain/usecases/tv/save_watchlisttv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_detail_state.dart';

class TVDetailCubit extends Cubit<TVDetailState> {
  TVDetailCubit({
    required this.getTVDetail,
    required this.saveWatchlist,
    required this.removeWatchlist,
    required this.getWatchListStatus,
  }) : super(const TVDetailState());

  final GetTVDetail getTVDetail;
  final SaveWatchlistTV saveWatchlist;
  final RemoveWatchlistTV removeWatchlist;
  final GetWatchListStatus getWatchListStatus;

  /// Message
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  Future<void> get(int id) async {
    emit(state.setRequestState(RequestState.Loading));
    final result = await getTVDetail.execute(id);
    result.fold(
      (failure) {
        emit(state.setMessage(failure.message));
        emit(state.setRequestState(RequestState.Error));
      },
      (tv) {
        emit(state.setRequestState(RequestState.Loaded));
        emit(state.setTV(tv));
      },
    );
  }

  Future<void> addWatchlist(TVDetail tv) async {
    final result = await saveWatchlist.execute(tv);
    result.fold(
      (failure) => emit(state.setMessageWatchlist(failure.message)),
      (value) => emit(state.setMessageWatchlist(value)),
    );
    await getWatchlistStatus(tv.id);
  }

  Future<void> deleteWatchlist(TVDetail tv) async {
    final result = await removeWatchlist.execute(tv);
    result.fold(
      (failure) => emit(state.setMessageWatchlist(failure.message)),
      (value) => emit(state.setMessageWatchlist(value)),
    );
    await getWatchlistStatus(tv.id);
  }

  Future<void> getWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    emit(state.setAddedToWatchlist(result));
  }
}

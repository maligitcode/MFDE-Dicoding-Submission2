import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_watchlist_state.dart';

class TVWatchlistCubit extends Cubit<TVWatchlistState> {
  TVWatchlistCubit({
    required this.getWatchlistTV,
  }) : super(const TVWatchlistInitialState());

  final GetWatchlistTV getWatchlistTV;

  Future<void> get() async {
    emit(const TVWatchlistLoadingState());
    final result = await getWatchlistTV.execute();
    result.fold(
      (failure) => emit(TVWatchlistErrorState(failure.message)),
      (values) => emit(TVWatchlistLoadedState(items: values)),
    );
  }
}

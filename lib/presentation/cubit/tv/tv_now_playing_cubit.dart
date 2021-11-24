import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_now_playing_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part  'tv_now_playing_state.dart';

class TVNowPlayingCubit extends Cubit<TVNowPlayingState> {
  TVNowPlayingCubit({
    required this.getNowPlayingTV,
  }) : super(const TVNowPlayingInitialState());

  final GetNowPlayingTV getNowPlayingTV;
  Future<void> get() async {
    emit(const TVNowPlayingLoadingState());

    final result = await getNowPlayingTV.execute();
    result.fold(
          (failure) => emit(TVNowPlayingErrorState(failure.message)),
          (values) => emit(TVNowPlayingLoadedState(items: values)),
    );
  }
}

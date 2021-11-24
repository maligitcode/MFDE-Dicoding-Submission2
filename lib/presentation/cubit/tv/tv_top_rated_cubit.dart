import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/tv.dart';
import '../../../domain/usecases/tv/get_top_rated_tv.dart';

part './tv_top_rated_state.dart';

class TVTopRatedCubit extends Cubit<TVTopRatedState> {
  TVTopRatedCubit({
    required this.getTopRatedTVs,
  }) : super(const TVTopRatedInitialState());

  final GetTopRatedTV getTopRatedTVs;
  Future<void> get() async {
    emit(const TVTopRatedLoadingState());

    final result = await getTopRatedTVs.execute();
    result.fold(
      (failure) => emit(TVTopRatedErrorState(failure.message)),
      (values) => emit(TVTopRatedLoadedState(items: values)),
    );
  }
}

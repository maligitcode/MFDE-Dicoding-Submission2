import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_popular_state.dart';

class TVPopularCubit extends Cubit<TVPopularState> {
  TVPopularCubit({
    required this.getPopularTVs,
  }) : super(const TVPopularInitialState());

  final GetPopularTV getPopularTVs;
  Future<void> get() async {
    emit(const TVPopularLoadingState());

    final result = await getPopularTVs.execute();

    result.fold(
      (failure) => emit(TVPopularErrorState(failure.message)),
      (values) => emit(TVPopularLoadedState(items: values)),
    );
  }
}

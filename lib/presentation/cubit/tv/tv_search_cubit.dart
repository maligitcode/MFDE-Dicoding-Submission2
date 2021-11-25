import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/search_moviestv.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'tv_search_state.dart';

class TVSearchCubit extends Cubit<TVSearchState> {
  TVSearchCubit({
    required this.searchTVSeries,
  }) : super(const TVSearchInitial());

  final SearchTV searchTVSeries;
  Future<void> get(String query) async {
    emit(const TVSearhLoadingState());
    final result = await searchTVSeries.execute(query);
    result.fold(
          (failure) => emit(
        TVSearchErrorState(failure.message),
      ),
          (values) => emit(
        TVSearchLoadedState(items: values),
      ),
    );
  }
}

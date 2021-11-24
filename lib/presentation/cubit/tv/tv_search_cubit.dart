import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/search_moviestv.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'tv_search_state.dart';

class TVSearchCubit extends Cubit<TVSearchState> {
  TVSearchCubit({required this.getSearchTVs})
      : super(TVSearchInitial());
  final SearchTV getSearchTVs;

  Future<void> get(String query) async {
    emit(const TVSearhLoadingState());
    final result = await getSearchTVs.execute(query);
    result.fold((failure) => emit(TVSearchErrorState(failure.message)),
        (values) => TVSearchLoadedState(items: values));
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/tv.dart';
import '../../../domain/usecases/tv/get_tv_recommendations.dart';

part './tv_recommendations_state.dart';

class TVRecommendationsCubit extends Cubit<TVRecommendationsState> {
  TVRecommendationsCubit({
    required this.getTVRecommendations,
  }) : super(const TVRecommendationsInitialState());
  final GetTVRecommendations getTVRecommendations;

  Future<void> get(int id) async {
    emit(const TVRecommendationsLoadingState());
    final result = await getTVRecommendations.execute(id);
    result.fold(
      (failure) => emit(TVRecommendationsErrorState(failure.message)),
      (values) => emit(TVRecommendationsLoadedState(items: values)),
    );
  }
}

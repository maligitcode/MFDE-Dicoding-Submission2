part of 'tv_recommendations_cubit.dart';

abstract class TVRecommendationsState extends Equatable {
  const TVRecommendationsState();

  @override
  List<Object> get props => [];
}

class TVRecommendationsInitialState extends TVRecommendationsState {
  const TVRecommendationsInitialState();
}

class TVRecommendationsLoadingState extends TVRecommendationsState {
  const TVRecommendationsLoadingState();
}

class TVRecommendationsErrorState extends TVRecommendationsState {
  const TVRecommendationsErrorState(
    this.message,
  );

  final String message;

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => true;

  TVRecommendationsErrorState copyWith({
    String? message,
  }) {
    return TVRecommendationsErrorState(
      message ?? this.message,
    );
  }
}

class TVRecommendationsLoadedState extends TVRecommendationsState {
  const TVRecommendationsLoadedState({
    required this.items,
  });

  final List<TV> items;

  @override
  List<Object> get props => [items];

  @override
  bool get stringify => true;

  TVRecommendationsLoadedState copyWith({
    List<TV>? items,
  }) {
    return TVRecommendationsLoadedState(
      items: items ?? this.items,
    );
  }
}

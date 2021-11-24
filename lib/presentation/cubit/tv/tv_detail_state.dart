part of 'tv_detail_cubit.dart';

class TVDetailState extends Equatable {
  final TVDetail movie;
  final bool isAddedToWatchlist;
  final String message;
  final String messageWatchlist;
  final RequestState requestState;

  const TVDetailState({
    this.movie = const TVDetail(),
    this.isAddedToWatchlist = false,
    this.message = '',
    this.messageWatchlist = '',
    this.requestState = RequestState.Empty,
  });

  TVDetailState setTV(TVDetail movie) => copyWith(movie: movie);
  TVDetailState setAddedToWatchlist(bool value) => copyWith(isAddedToWatchlist: value);
  TVDetailState setRequestState(RequestState requestState) =>
      copyWith(requestState: requestState);
  TVDetailState setMessage(String message) => copyWith(message: message);
  TVDetailState setMessageWatchlist(String message) => copyWith(messageWatchlist: message);

  @override
  List<Object> get props {
    return [
      movie,
      isAddedToWatchlist,
      message,
      messageWatchlist,
      requestState,
    ];
  }

  @override
  bool get stringify => true;

  TVDetailState copyWith({
    TVDetail? movie,
    bool? isAddedToWatchlist,
    String? message,
    String? messageWatchlist,
    RequestState? requestState,
  }) {
    return TVDetailState(
      movie: movie ?? this.movie,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      message: message ?? this.message,
      messageWatchlist: messageWatchlist ?? this.messageWatchlist,
      requestState: requestState ?? this.requestState,
    );
  }
}

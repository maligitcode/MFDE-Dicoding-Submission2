part of 'tv_detail_cubit.dart';

class TVDetailState extends Equatable {
  final TVDetail tv;
  final bool isAddedToWatchlist;
  final String message;
  final String messageWatchlist;
  final RequestState requestState;

  const TVDetailState({
    this.tv = const TVDetail(),
    this.isAddedToWatchlist = false,
    this.message = '',
    this.messageWatchlist = '',
    this.requestState = RequestState.Empty,
  });

  TVDetailState setTV(TVDetail tv) => copyWith(tv: tv);
  TVDetailState setAddedToWatchlist(bool value) => copyWith(isAddedToWatchlist: value);
  TVDetailState setRequestState(RequestState requestState) =>
      copyWith(requestState: requestState);
  TVDetailState setMessage(String message) => copyWith(message: message);
  TVDetailState setMessageWatchlist(String message) => copyWith(messageWatchlist: message);

  @override
  List<Object> get props {
    return [
      tv,
      isAddedToWatchlist,
      message,
      messageWatchlist,
      requestState,
    ];
  }

  @override
  bool get stringify => true;

  TVDetailState copyWith({
    TVDetail? tv,
    bool? isAddedToWatchlist,
    String? message,
    String? messageWatchlist,
    RequestState? requestState,
  }) {
    return TVDetailState(
      tv: tv ?? this.tv,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      message: message ?? this.message,
      messageWatchlist: messageWatchlist ?? this.messageWatchlist,
      requestState: requestState ?? this.requestState,
    );
  }
}

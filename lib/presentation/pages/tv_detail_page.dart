import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/cubit/tv/tv_detail_cubit.dart';
import 'package:ditonton/presentation/cubit/tv/tv_recommendations_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class TVDetailPage extends StatefulWidget {

  static const ROUTE_NAME = '/detailtv';

  final int id;

  const TVDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _TVDetailPageState createState() => _TVDetailPageState();
}

class _TVDetailPageState extends State<TVDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TVDetailCubit>().get(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TVDetailCubit, TVDetailState>(
        builder: (context, state) {
          final requestState = state.requestState;

          if (requestState == RequestState.Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (requestState == RequestState.Loaded) {
            return SafeArea(
              child: DetailContent(tv: state.tv),
            );
          } else if (requestState == RequestState.Error) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatefulWidget {
  final TVDetail tv;

  const DetailContent({Key? key, required this.tv}) : super(key: key);

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TVRecommendationsCubit>().get(widget.tv.id);
      context.read<TVDetailCubit>().getWatchlistStatus(widget.tv.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${widget.tv.poster_path}',
          width: screenWidth,
          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tv.name,
                              style: kHeading5,
                            ),
                            BlocBuilder<TVDetailCubit, TVDetailState>(
                              builder: (context, state) {
                                return ElevatedButton(
                                  onPressed: () async {
                                    if (!state.isAddedToWatchlist) {
                                      await context
                                          .read<TVDetailCubit>()
                                          .addWatchlist(widget.tv);
                                    } else {
                                      await context
                                          .read<TVDetailCubit>()
                                          .deleteWatchlist(widget.tv);
                                    }

                                    final message =
                                        context.read<TVDetailCubit>().state.messageWatchlist;

                                    if (message == TVDetailCubit.watchlistAddSuccessMessage ||
                                        message == TVDetailCubit.watchlistRemoveSuccessMessage) {
                                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(content: Text(message)));
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(message),
                                          );
                                        },
                                      );
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      state.isAddedToWatchlist
                                          ? const Icon(Icons.check)
                                          : const Icon(Icons.add),
                                      const Text('Watchlist'),
                                    ],
                                  ),
                                );
                              },
                            ),
                            Text(
                              _showGenres(widget.tv.genres),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.tv.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.tv.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TVRecommendationsCubit, TVRecommendationsState>(
                              builder: (context, state) {
                                if (state is TVRecommendationsLoadingState) {
                                  return const Center(child: CircularProgressIndicator());
                                } else if (state is TVRecommendationsErrorState) {
                                  return Text(state.message);
                                } else if (state is TVRecommendationsLoadedState) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tv = state.items[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TVDetailPage.ROUTE_NAME,
                                                arguments: tv.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                'https://image.tmdb.org/t/p/w500${tv.poster_path}',
                                                placeholder: (context, url) => const Center(
                                                  child: CircularProgressIndicator(),
                                                ),
                                                errorWidget: (context, url, error) =>
                                                const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.items.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}


import 'package:ditonton/presentation/cubit/movie/movie_now_playing_cubit.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class NowplayingMoviePage extends StatefulWidget {
  static const ROUTE_NAME = '/playing-movie';

  @override
  _NowplayingMoviePageState createState() => _NowplayingMoviePageState();
}

class _NowplayingMoviePageState extends State<NowplayingMoviePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
          () => context.read<MovieNowPlayingCubit>().get(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MovieNowPlayingCubit, MovieNowPlayingState>(
          builder: (context, state) {
            if (state is MovieNowPlayingLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MovieNowPlayingLoadedState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.items[index];
                  return MovieCard(movie: movie);
                },
                itemCount: state.items.length,
              );
            } else if (state is MovieNowPlayingErrorState) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

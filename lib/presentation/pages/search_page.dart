import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/cubit/movie/movie_search_cubit.dart';
import 'package:ditonton/presentation/cubit/tv/tv_search_cubit.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';
  String? searchoption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) async {
                await context.read<MovieSearchCubit>().get(query);
              },
              decoration: InputDecoration(
                hintText: 'Search movie',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            TextField(
              onSubmitted: (query) async {
                await context.read<TVSearchCubit>().get(query);
              },
              decoration: InputDecoration(
                hintText: 'Search tv',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<MovieSearchCubit, MovieSearchState>(
              builder: (context, state) {
                if (state is MovieSearhLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MovieSearchLoadedState) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final movie = state.items[index];
                      return MovieCard(movie: movie);
                    },
                    itemCount: state.items.length,
                  );
                } else if (state is MovieSearchErrorState) {
                  return Center(
                    key: const Key('error_message'),
                    child: Text(state.message),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            BlocBuilder<TVSearchCubit, TVSearchState>(
              builder: (context, state) {
                if (state is TVSearhLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TVSearchLoadedState) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final movie = state.items[index];
                      return TVCard(tv: movie);
                    },
                    itemCount: state.items.length,
                  );
                } else if (state is TVSearchErrorState) {
                  return Center(
                    key: const Key('error_message'),
                    child: Text(state.message),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

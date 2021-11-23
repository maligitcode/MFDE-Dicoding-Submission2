import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/cubit/movie/movie_search_cubit.dart';
import 'package:ditonton/presentation/provider/tv/tv_search_notifier.dart';
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
              onSubmitted: (query) {
                context.read<MovieSearchCubit>().get(query);
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
              onSubmitted: (query) {
                Provider.of<TVSearchNotifier>(context, listen: false)
                    .fetchTVSearch(query);
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
            Consumer<TVSearchNotifier>(
              builder: (context, data, child) {
                if (data.state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data.state == RequestState.Loaded) {
                  final result = data.searchResult;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final tv = data.searchResult[index];
                        return TVCard(tv);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

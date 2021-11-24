import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/cubit/tv/tv_top_rated_cubit.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TopRatedTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';

  @override
  _TopRatedTVPageState createState() => _TopRatedTVPageState();
}

class _TopRatedTVPageState extends State<TopRatedTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
          () => context.read<TVTopRatedCubit>().get(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TVTopRatedCubit, TVTopRatedState>(
          builder: (context, state) {
            if (state is TVTopRatedLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TVTopRatedLoadedState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.items[index];
                  return TVCard(tv: tv);
                },
                itemCount: state.items.length,
              );
            } else if (state is TVTopRatedErrorState) {
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

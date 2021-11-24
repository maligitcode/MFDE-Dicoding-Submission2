import 'package:ditonton/presentation/cubit/tv/tv_popular_cubit.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class PopularTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';

  @override
  _PopularTVPageState createState() => _PopularTVPageState();
}

class _PopularTVPageState extends State<PopularTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
          () => context.read<TVPopularCubit>().get(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TVPopularCubit, TVPopularState>(
          builder: (context, state) {
            if (state is TVPopularLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TVPopularLoadedState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.items[index];
                  return TVCard(tv: tv);
                },
                itemCount: state.items.length,
              );
            } else if (state is TVPopularErrorState) {
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

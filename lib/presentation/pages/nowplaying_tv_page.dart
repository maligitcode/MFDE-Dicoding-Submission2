import 'package:ditonton/presentation/cubit/tv/tv_now_playing_cubit.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class NowplayingTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/playing-tv';

  @override
  _NowplayingTVPageState createState() => _NowplayingTVPageState();
}

class _NowplayingTVPageState extends State<NowplayingTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
          () => context.read<TVNowPlayingCubit>().get(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TVNowPlayingCubit, TVNowPlayingState>(
          builder: (context, state) {
            if (state is TVNowPlayingLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TVNowPlayingLoadedState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.items[index];
                  return TVCard(tv: tv);
                },
                itemCount: state.items.length,
              );
            } else if (state is TVNowPlayingErrorState) {
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

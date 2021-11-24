import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/cubit/tv/tv_watchlist_cubit.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class WatchlistTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv';

  @override
  _WatchlistTVPageState createState() => _WatchlistTVPageState();
}

class _WatchlistTVPageState extends State<WatchlistTVPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
          () {
        context.read<TVWatchlistCubit>().get();
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }


  void didPopNext() {
    context.read<TVWatchlistCubit>().getWatchlistTV;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TVWatchlistCubit, TVWatchlistState>(
          builder: (context, state) {
            if (state is TVWatchlistLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TVWatchlistLoadedState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.items[index];
                  return TVCard(tv: tv);
                },
                itemCount: state.items.length,
              );
            } else if (state is TVWatchlistErrorState) {
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

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}

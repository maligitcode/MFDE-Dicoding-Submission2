import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/cubit/movie/movie_detail_cubit.dart';
import 'package:ditonton/presentation/cubit/movie/movie_now_playing_cubit.dart';
import 'package:ditonton/presentation/cubit/movie/movie_popular_cubit.dart';
import 'package:ditonton/presentation/cubit/movie/movie_recommendations_cubit.dart';
import 'package:ditonton/presentation/cubit/movie/movie_top_rated_cubit.dart';
import 'package:ditonton/presentation/cubit/movie/movie_watchlist_cubit.dart';
import 'package:ditonton/presentation/cubit/tv/tv_detail_cubit.dart';
import 'package:ditonton/presentation/cubit/tv/tv_now_playing_cubit.dart';
import 'package:ditonton/presentation/cubit/tv/tv_popular_cubit.dart';
import 'package:ditonton/presentation/cubit/tv/tv_recommendations_cubit.dart';
import 'package:ditonton/presentation/cubit/tv/tv_top_rated_cubit.dart';
import 'package:ditonton/presentation/cubit/tv/tv_watchlist_cubit.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/nowplaying_tv_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_page.dart';
import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_tv_page.dart';
import 'package:ditonton/presentation/pages/nowplaying_movies_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;


// 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
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<MovieWatchlistCubit>(
          create: (context) => di.locator<MovieWatchlistCubit>(),
        ),
        BlocProvider<MovieNowPlayingCubit>(
          create: (context) => di.locator<MovieNowPlayingCubit>(),
        ),
        BlocProvider<MoviePopularCubit>(
          create: (context) => di.locator<MoviePopularCubit>(),
        ),
        BlocProvider<MovieTopRatedCubit>(
          create: (context) => di.locator<MovieTopRatedCubit>(),
        ),
        BlocProvider<MovieRecommendationsCubit>(
          create: (context) => di.locator<MovieRecommendationsCubit>(),
        ),
        BlocProvider<MovieDetailCubit>(
          create: (context) => di.locator<MovieDetailCubit>(),
        ),
      //  TV Series
        BlocProvider<TVWatchlistCubit>(
          create: (context) => di.locator<TVWatchlistCubit>(),
        ),
        BlocProvider<TVNowPlayingCubit>(
          create: (context) => di.locator<TVNowPlayingCubit>(),
        ),
        BlocProvider<TVPopularCubit>(
          create: (context) => di.locator<TVPopularCubit>(),
        ),
        BlocProvider<TVTopRatedCubit>(
          create: (context) => di.locator<TVTopRatedCubit>(),
        ),
        BlocProvider<TVRecommendationsCubit>(
          create: (context) => di.locator<TVRecommendationsCubit>(),
        ),
        BlocProvider<TVDetailCubit>(
          create: (context) => di.locator<TVDetailCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          accentColor: kMikadoYellow,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case TVDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TVDetailPage(id: id),
                settings: settings,
              );
            case NowplayingTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => NowplayingTVPage());
            case PopularTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTVPage());
            case TopRatedTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTVPage());
            case WatchlistTVPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTVPage());
            case NowplayingMoviePage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => NowplayingMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}

import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/cubit/movie/movie_detail_cubit.dart';
import 'package:ditonton/presentation/cubit/movie/movie_now_playing_cubit.dart';
import 'package:ditonton/presentation/cubit/movie/movie_popular_cubit.dart';
import 'package:ditonton/presentation/cubit/movie/movie_recommendations_cubit.dart';
import 'package:ditonton/presentation/cubit/movie/movie_search_cubit.dart';
import 'package:ditonton/presentation/cubit/movie/movie_top_rated_cubit.dart';
import 'package:ditonton/presentation/cubit/movie/movie_watchlist_cubit.dart';
import 'package:ditonton/presentation/cubit/tv/tv_detail_cubit.dart';
import 'package:ditonton/presentation/cubit/tv/tv_now_playing_cubit.dart';
import 'package:ditonton/presentation/cubit/tv/tv_popular_cubit.dart';
import 'package:ditonton/presentation/cubit/tv/tv_recommendations_cubit.dart';
import 'package:ditonton/presentation/cubit/tv/tv_search_cubit.dart';
import 'package:ditonton/presentation/cubit/tv/tv_top_rated_cubit.dart';
import 'package:ditonton/presentation/cubit/tv/tv_watchlist_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'common/ssl_pinning.dart';
import 'data/datasources/tv_local_data_source.dart';
import 'data/datasources/tv_remote_data_source.dart';
import 'data/repositories/tv_repository_impl.dart';
import 'domain/repositories/tv_repository.dart';
import 'domain/usecases/tv/get_now_playing_tv.dart';
import 'domain/usecases/tv/get_popular_tv.dart';
import 'domain/usecases/tv/get_top_rated_tv.dart';
import 'domain/usecases/tv/get_tv_detail.dart';
import 'domain/usecases/tv/get_tv_recommendations.dart';
import 'domain/usecases/tv/get_watchlist_tv.dart';
import 'domain/usecases/tv/get_watchlisttv_status.dart';
import 'domain/usecases/tv/remove_watchlisttv.dart';
import 'domain/usecases/tv/save_watchlisttv.dart';
import 'domain/usecases/tv/search_moviestv.dart';

final locator = GetIt.instance;

void init() {
  // provider movie
  locator.registerFactory(
        () => MovieWatchlistCubit(
      getWatchlistMovies: locator(),
    ),
  );

  locator.registerFactory(
        () => MovieNowPlayingCubit(
      getNowPlayingMovies: locator(),
    ),
  );

  locator.registerFactory(
        () => MoviePopularCubit(
      getPopularMovies: locator(),
    ),
  );

  locator.registerFactory(
        () => MovieTopRatedCubit(
      getTopRatedMovies: locator(),
    ),
  );

  locator.registerFactory(
        () => MovieRecommendationsCubit(
      getMovieRecommendations: locator(),
    ),
  );

  locator.registerFactory(
        () => MovieDetailCubit(
      getMovieDetail: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
      getWatchListStatus: locator(),
    ),
  );

  // provider tv
  locator.registerFactory(
        () => TVWatchlistCubit(
      getWatchlistTV: locator(),
    ),
  );

  locator.registerFactory(
        () => TVNowPlayingCubit(
      getNowPlayingTV: locator(),
    ),
  );

  locator.registerFactory(
        () => TVPopularCubit(
      getPopularTV: locator(),
    ),
  );

  locator.registerFactory(
        () => TVTopRatedCubit(
      getTopRatedTV: locator(),
    ),
  );

  locator.registerFactory(
        () => TVRecommendationsCubit(
      getTVRecommendations: locator(),
    ),
  );

  locator.registerFactory(
        () => TVDetailCubit(
      getTVDetail: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
      getWatchListStatus: locator(),
    ),
  );

  locator.registerFactory(
        () => MovieSearchCubit(
          getSearchMovies: locator()
        ),
  );

  locator.registerFactory(
        () => TVSearchCubit(
        getSearchTVs: locator()
    ),
  );
  // use case movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // use case tv
  locator.registerLazySingleton(() => GetNowPlayingTV(locator()));
  locator.registerLazySingleton(() => GetPopularTV(locator()));
  locator.registerLazySingleton(() => GetTopRatedTV(locator()));
  locator.registerLazySingleton(() => GetTVDetail(locator()));
  locator.registerLazySingleton(() => GetTVRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTV(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTV(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTV(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTV(locator()));
  locator.registerLazySingleton(() => GetWatchlistTV(locator()));

  // repository movie
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // repository tv
  locator.registerLazySingleton<TVRepository>(
        () => TVRepositoryImpl(
          remoteDataSource: locator(),
          localDataSource: locator(),
    ),
  );

  // data sources movie
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // data sources tv
  locator.registerLazySingleton<TVRemoteDataSource>(
          () => TVRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TVLocalDataSource>(
          () => TVLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  // locator.registerLazySingleton(() => http.Client());

  locator.registerLazySingleton(() => HttpSSLPinning.client);
}

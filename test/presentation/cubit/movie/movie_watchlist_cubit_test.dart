import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/presentation/cubit/movie/movie_watchlist_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_notifier_test.mocks.dart';
@GenerateMocks([GetWatchlistMovies])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MovieWatchlistCubit cubit;
  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    cubit = MovieWatchlistCubit(getWatchlistMovies: mockGetWatchlistMovies);
  });

  tearDown(() async {
    await cubit.close();
  });

  group(
    'Movie Watchlist',
    () {
      blocTest<MovieWatchlistCubit, MovieWatchlistState>(
        'Should emitsInOrder [Loading, Loaded] when success',
        build: () {
          when(mockGetWatchlistMovies.execute())
              .thenAnswer((realInvocation) async => Right(testMovieList));
          return cubit;
        },
        act: (bloc) => bloc.get(),
        expect: () => [
          const MovieWatchlistLoadingState(),
          MovieWatchlistLoadedState(items: testMovieList),
        ],
      );

      blocTest<MovieWatchlistCubit, MovieWatchlistState>(
        'Should emitsInOrder [Loading, Error] when success',
        build: () {
          when(mockGetWatchlistMovies.execute())
              .thenAnswer((realInvocation) async =>  Left(ServerFailure('error')));
          return cubit;
        },
        act: (bloc) => bloc.get(),
        expect: () => [
          const MovieWatchlistLoadingState(),
          const MovieWatchlistErrorState('error'),
        ],
      );
    },
  );
}

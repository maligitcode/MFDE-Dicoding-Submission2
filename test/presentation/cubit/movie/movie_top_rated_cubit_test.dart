import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/cubit/movie/movie_top_rated_cubit.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_movies_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MovieTopRatedCubit cubit;
  setUp(
    () {
      mockGetTopRatedMovies = MockGetTopRatedMovies();
      cubit = MovieTopRatedCubit(getTopRatedMovies: mockGetTopRatedMovies);
    },
  );

  tearDown(() async {
    await cubit.close();
  });

  group(
    'Movie Top Rated',
    () {
      blocTest<MovieTopRatedCubit, MovieTopRatedState>(
        'Should emitsInOrder [Loading, Loaded] when success',
        build: () {
          when(mockGetTopRatedMovies.execute()).thenAnswer((_) async => Right(testMovieList));
          return cubit;
        },
        act: (bloc) => bloc.get(),
        expect: () => [
          const MovieTopRatedLoadingState(),
          MovieTopRatedLoadedState(items: testMovieList),
        ],
      );

      blocTest<MovieTopRatedCubit, MovieTopRatedState>(
        'Should emitsInOrder [Loading, Error] when unsuccess',
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async =>  Left(ServerFailure('error')));
          return cubit;
        },
        act: (bloc) => bloc.get(),
        expect: () => [
          const MovieTopRatedLoadingState(),
          const MovieTopRatedErrorState('error'),
        ],
      );
    },
  );
}

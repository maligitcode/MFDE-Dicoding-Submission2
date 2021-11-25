import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/search_moviestv.dart';
import 'package:ditonton/presentation/cubit/tv/tv_search_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ditonton/domain/entities/tv.dart';

import 'tv_search_notifier_test.mocks.dart';


@GenerateMocks([SearchTV])
void main() {
  late MockSearchTV mockSearchTV;
  late TVSearchCubit cubit;
  setUp(() {
    mockSearchTV = MockSearchTV();
    cubit = TVSearchCubit(getSearchTVs: mockSearchTV);
  });

  tearDown(() async {
    await cubit.close();
  });

  final tTVModel = TV(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    original_name: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    poster_path: 'posterPath',
    first_air_date:  'releaseDate',
    name : 'title',
    original_language: 'EN',
    voteAverage: 1,
    voteCount: 1,
  );
  final tTVList = <TV>[tTVModel];
  const tQuery = 'spiderman';
  group(
    'TV Search',
        () {
      blocTest<TVSearchCubit, TVSearchState>(
        'Should emitsInOrder [Loading, Loaded] when success ',
        build: () {
          when(mockSearchTV.execute(tQuery)).thenAnswer((_) async => Right(tTVList));

          return cubit;
        },
        act: (bloc) => bloc.get(tQuery),
        expect: () => [
          const TVSearhLoadingState(),
          // TVSearchLoadedState(items: tTVList),
        ],
      );

      blocTest<TVSearchCubit, TVSearchState>(
        'Should emitsInOrder [Loading, Error] when unsuccess ',
        build: () {
          when(mockSearchTV.execute(tQuery))
              .thenAnswer((_) async =>  Left(ServerFailure('error')));

          return cubit;
        },
        act: (bloc) => bloc.get(tQuery),
        expect: () => [
          const TVSearhLoadingState(),
          const TVSearchErrorState('error'),
        ],
      );
    },
  );
}

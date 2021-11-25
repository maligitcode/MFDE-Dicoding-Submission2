import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:ditonton/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:ditonton/presentation/cubit/tv/tv_top_rated_cubit.dart';

import '../../../dummy_data/dummy_objectstv.dart';
import 'top_rated_tv_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTV])
void main() {
  late MockGetTopRatedTV mockGetTopRatedTV;
  late TVTopRatedCubit cubit;
  setUp(
    () {
      mockGetTopRatedTV = MockGetTopRatedTV();
      cubit = TVTopRatedCubit(getTopRatedTV: mockGetTopRatedTV);
    },
  );

  tearDown(() async {
    await cubit.close();
  });

  group(
    'TV Top Rated',
    () {
      blocTest<TVTopRatedCubit, TVTopRatedState>(
        'Should emitsInOrder [Loading, Loaded] when success',
        build: () {
          when(mockGetTopRatedTV.execute()).thenAnswer((_) async => Right(testTVList));
          return cubit;
        },
        act: (bloc) => bloc.get(),
        expect: () => [
          const TVTopRatedLoadingState(),
          TVTopRatedLoadedState(items: testTVList),
        ],
      );

      blocTest<TVTopRatedCubit, TVTopRatedState>(
        'Should emitsInOrder [Loading, Error] when unsuccess',
        build: () {
          when(mockGetTopRatedTV.execute())
              .thenAnswer((_) async =>  Left(ServerFailure('error')));
          return cubit;
        },
        act: (bloc) => bloc.get(),
        expect: () => [
          const TVTopRatedLoadingState(),
          const TVTopRatedErrorState('error'),
        ],
      );
    },
  );
}

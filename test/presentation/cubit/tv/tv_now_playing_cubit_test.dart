import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:ditonton/domain/usecases/tv/get_now_playing_tv.dart';
import 'package:ditonton/presentation/cubit/tv/tv_now_playing_cubit.dart';

import '../../../dummy_data/dummy_objectstv.dart';
import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingTV])
void main() {
  late MockGetNowPlayingTV mockGetNowPlayingTV;
  late TVNowPlayingCubit cubit;

  setUp(() {
    mockGetNowPlayingTV = MockGetNowPlayingTV();
    cubit = TVNowPlayingCubit(
      getNowPlayingTV: mockGetNowPlayingTV,
    );
  });

  tearDown(() async {
    await cubit.close();
  });

  group(
    'TV Now Playing',
    () {
      blocTest<TVNowPlayingCubit, TVNowPlayingState>(
        'should emitsInOrder [Loading, Loaded] when success',
        build: () {
          when(mockGetNowPlayingTV.execute()).thenAnswer((_) async => Right(testTVList));
          return cubit;
        },
        act: (bloc) => bloc.get(),
        expect: () => [
          const TVNowPlayingLoadingState(),
          TVNowPlayingLoadedState(items: testTVList),
        ],
      );

      blocTest<TVNowPlayingCubit, TVNowPlayingState>(
        'should emitsInOrder [Loading, Error] when unsuccess',
        build: () {
          when(mockGetNowPlayingTV.execute())
              .thenAnswer((_) async =>  Left(ServerFailure('error')));
          return cubit;
        },
        act: (bloc) => bloc.get(),
        expect: () => [
          const TVNowPlayingLoadingState(),
          const TVNowPlayingErrorState('error'),
        ],
      );
    },
  );
}

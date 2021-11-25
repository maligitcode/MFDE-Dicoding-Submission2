import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:ditonton/presentation/cubit/tv/tv_watchlist_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objectstv.dart';
import 'watchlist_tv_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistTV])
void main() {
  late MockGetWatchlistTV mockGetWatchlistTV;
  late TVWatchlistCubit cubit;
  setUp(() {
    mockGetWatchlistTV = MockGetWatchlistTV();
    cubit = TVWatchlistCubit(getWatchlistTV: mockGetWatchlistTV);
  });

  tearDown(() async {
    await cubit.close();
  });

  group(
    'TV Watchlist',
    () {
      blocTest<TVWatchlistCubit, TVWatchlistState>(
        'Should emitsInOrder [Loading, Loaded] when success',
        build: () {
          when(mockGetWatchlistTV.execute())
              .thenAnswer((realInvocation) async => Right(testTVList));
          return cubit;
        },
        act: (bloc) => bloc.get(),
        expect: () => [
          const TVWatchlistLoadingState(),
          TVWatchlistLoadedState(items: testTVList),
        ],
      );

      blocTest<TVWatchlistCubit, TVWatchlistState>(
        'Should emitsInOrder [Loading, Error] when success',
        build: () {
          when(mockGetWatchlistTV.execute())
              .thenAnswer((realInvocation) async =>  Left(ServerFailure('error')));
          return cubit;
        },
        act: (bloc) => bloc.get(),
        expect: () => [
          const TVWatchlistLoadingState(),
          const TVWatchlistErrorState('error'),
        ],
      );
    },
  );
}

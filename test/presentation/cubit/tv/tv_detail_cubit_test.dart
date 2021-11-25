// import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/cubit/tv/tv_detail_cubit.dart';
import '../../../dummy_data/dummy_objectstv.dart';
import 'tv_detail_test.mocks.dart';

@GenerateMocks([
  GetTVDetail,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MockGetTVDetail mockGetTVDetail;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late TVDetailCubit cubit;
  setUp(() {
    mockGetTVDetail = MockGetTVDetail();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    cubit = TVDetailCubit(
      getTVDetail: mockGetTVDetail,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
      getWatchListStatus: mockGetWatchListStatus
    );
  });

  tearDown(() async {
    await cubit.close();
  });

  const id = 1;

  group(
    'TV Detail',
        () {
      test('state should be loading when first call', () async {
        /// arrange
        when(mockGetTVDetail.execute(id)).thenAnswer((_) async =>  Right(testTVDetail));

        /// act
        cubit.get(id);

        /// assert
        expect(cubit.state.requestState, RequestState.Loading);
      });

      test(
        'State should be loaded data when success',
            () async {
          /// arrange
          when(mockGetTVDetail.execute(id))
              .thenAnswer((_) async => Right(testTVDetail));

          /// act
          await cubit.get(id);

          /// assert
          expect(cubit.state.tv, testTVDetail);
        },
      );

      test(
        'State should be error when unsuccess',
            () async {
          /// arrange
          when(mockGetTVDetail.execute(id))
              .thenAnswer((_) async =>  Left(ServerFailure('error')));

          /// act
          await cubit.get(id);

          /// assert
          expect(cubit.state.requestState, RequestState.Error);
        },
      );
    },
  );

  group(
    'TV Detail Watchlist',
        () {
      test('should get watchlist status when function called', () async {
        /// arrange
        when(mockGetWatchListStatus.execute(id)).thenAnswer((_) async => true);

        /// act
        await cubit.getWatchlistStatus(id);

        /// assert
        expect(cubit.state.isAddedToWatchlist, true);
      });

      test(
        'should execute save watchlist when function called',
            () async {
          /// arrange
          when(mockSaveWatchlist.execute(testTVDetail))
              .thenAnswer((_) async => const Right('success insert'));
          when(mockGetWatchListStatus.execute(testTVDetail.id)).thenAnswer((_) async => true);

          /// act
          await cubit.addWatchlist(testTVDetail);

          /// assert
          expect(cubit.state.messageWatchlist, 'success insert');
          verify(mockSaveWatchlist.execute(testTVDetail));
        },
      );

      test(
        'should update message watchlist when save function error',
            () async {
          /// arrange
          when(mockSaveWatchlist.execute(testTVDetail))
              .thenAnswer((_) async => Left(DatabaseFailure('error')));
          when(mockGetWatchListStatus.execute(testTVDetail.id)).thenAnswer((_) async => true);

          /// act
          await cubit.addWatchlist(testTVDetail);

          /// assert
          expect(cubit.state.messageWatchlist, 'error');
        },
      );

      test(
        'should execute save watchlist when function called',
            () async {
          /// arrange
          when(mockRemoveWatchlist.execute(testTVDetail))
              .thenAnswer((_) async => const Right('success remove'));
          when(mockGetWatchListStatus.execute(testTVDetail.id)).thenAnswer((_) async => true);

          /// act
          await cubit.deleteWatchlist(testTVDetail);

          /// assert
          expect(cubit.state.messageWatchlist, 'success remove');
          verify(mockRemoveWatchlist.execute(testTVDetail));
        },
      );

      test(
        'should update message watchlist when remove function error',
            () async {
          /// arrange
          when(mockRemoveWatchlist.execute(testTVDetail))
              .thenAnswer((_) async =>  Left(DatabaseFailure('error')));
          when(mockGetWatchListStatus.execute(testTVDetail.id)).thenAnswer((_) async => true);

          /// act
          await cubit.deleteWatchlist(testTVDetail);

          /// assert
          expect(cubit.state.messageWatchlist, 'error');
        },
      );
    },
  );
}

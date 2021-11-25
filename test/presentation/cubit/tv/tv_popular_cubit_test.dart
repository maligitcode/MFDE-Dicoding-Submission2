import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:ditonton/presentation/cubit/tv/tv_popular_cubit.dart';

import '../../../dummy_data/dummy_objectstv.dart';
import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetPopularTV,
])
void main() {
  late MockGetPopularTV mockGetPopularTV;
  late TVPopularCubit cubit;

  setUp(() {
    mockGetPopularTV = MockGetPopularTV();
    cubit = TVPopularCubit(getPopularTV: mockGetPopularTV);
  });

  tearDown(() async {
    await cubit.close();
  });

  group(
    'TV Popular',
    () {
      blocTest<TVPopularCubit, TVPopularState>(
        'Should emitsInOrder [Loading, Loaded] when success',
        build: () {
          when(mockGetPopularTV.execute()).thenAnswer((_) async => Right(testTVList));
          return cubit;
        },
        act: (bloc) => bloc.get(),
        expect: () => [
          const TVPopularLoadingState(),
          TVPopularLoadedState(items: testTVList),
        ],
      );

      blocTest<TVPopularCubit, TVPopularState>(
        'Should emitsInOrder [Loading, Loaded] when unsuccess',
        build: () {
          when(mockGetPopularTV.execute())
              .thenAnswer((_) async =>  Left(ServerFailure('error')));
          return cubit;
        },
        act: (bloc) => bloc.get(),
        expect: () => [
          const TVPopularLoadingState(),
          const TVPopularErrorState('error'),
        ],
      );
    },
  );
}

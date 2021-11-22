import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv/save_watchlisttv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objectstv.dart';
import '../../../helpers/test_helpertv.mocks.dart';

void main() {
  late SaveWatchlistTV usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = SaveWatchlistTV(mockTVRepository);
  });

  test('should save movie to the repository', () async {
    // arrange
    when(mockTVRepository.saveWatchlist(testTVDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTVDetail);
    // assert
    verify(mockTVRepository.saveWatchlist(testTVDetail));
    expect(result, Right('Added to Watchlist'));
  });
}

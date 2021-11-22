import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/search_moviestv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helpertv.mocks.dart';

void main() {
  late SearchTV usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = SearchTV(mockTVRepository);
  });

  final tTV = <TV>[];
  final tQuery = 'Spiderman';

  test('should get list of tv from the repository', () async {
    // arrange
    when(mockTVRepository.searchTV(tQuery))
        .thenAnswer((_) async => Right(tTV));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTV));
  });
}

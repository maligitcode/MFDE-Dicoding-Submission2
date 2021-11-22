import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTVModel = TVModel(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    original_name: 'originalname',
    overview: 'overview',
    popularity: 1,
    poster_path: 'poster_path',
    first_air_date: 'first_air_date',
    name: 'name',
    original_language:  'original_language',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTV = TV(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    original_name: 'originalname',
    overview: 'overview',
    popularity: 1,
    poster_path: 'poster_path',
    first_air_date: 'first_air_date',
    name: 'name',
    original_language:  'original_language',
    voteAverage: 1,
    voteCount: 1,
  );

  test('should be a subclass of TV entity', () async {
    final result = tTVModel.toEntity();
    expect(result, tTV);
  });
}

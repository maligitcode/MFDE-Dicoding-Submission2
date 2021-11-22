import 'dart:convert';

import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

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
  final tTVResponseModel =
      TVResponse(tvList: <TVModel>[tTVModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_playingtv.json'));
      // act
      final result = TVResponse.fromJson(jsonMap);
      // assert
      expect(result, tTVResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTVResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdropPath": "backdropPath",
            "genreIds": [1, 2, 3],
            "id": 1,
            "original_name": "originalname",
            "overview": "overview",
            "popularity": 1,
            "poster_path": "poster_path",
            "first_air_date": "first_air_date",
            "name": "name",
            "original_language": "original_language",
            "vote_average": 1,
            "vote_count": 1
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}

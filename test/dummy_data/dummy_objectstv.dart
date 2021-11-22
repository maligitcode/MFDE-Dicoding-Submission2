import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

final testTV = TV(
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  original_name: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  poster_path: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  first_air_date: '2002-05-01',
  name: 'Spider-Man',
  voteAverage: 7.2,
  voteCount: 13507,
  original_language: 'EN',
);

final testTVList = [testTV];

final testTVDetail = TVDetail(
  backdropPath: "backdropPath",
  genres: [Genre(id: 1, name: "Action")],
  id: 1,
  original_name: "original_name",
  popularity: 1.0,
  overview: "overview",
  poster_path: "posterPath",
  first_air_date: "releaseDate",
  name: "name",
  voteAverage: 1,
  voteCount: 1,
  original_language: "en",
);

final testWatchlistTV = TV.watchlist(
  id: 1,
  name: 'name',
  poster_path: 'posterPath',
  overview: 'overview',
);

final testTVTable = TVTable(
  id: 1,
  name: "name",
  posterPath: "posterPath",
  overview: "overview",
);

final testTVMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};

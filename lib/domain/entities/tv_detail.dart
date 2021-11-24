import 'package:ditonton/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TVDetail extends Equatable {
  const TVDetail({
     this.backdropPath,
     this.first_air_date='',
     this.genres=const[],
     this.id=0,
     this.original_name='',
     this.name='',
     this.original_language='',
     this.overview='',
     this.popularity=0,
     this.poster_path='',
     this.voteAverage=0,
     this.voteCount
  });

  final String? backdropPath;
  final String first_air_date;
  final List<Genre> genres;
  final int id;
  final String original_name;
  final String name;
  final String original_language;
  final String overview;
  final double popularity;
  final String poster_path;
  final double voteAverage;
  final int? voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        first_air_date,
        genres,
        id,
        original_name,
        name,
        original_language,
        overview,
        popularity,
        poster_path,
        voteAverage,
        voteCount
      ];
}

import 'package:ditonton/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

class TVModel extends Equatable {
  TVModel({
    required this.backdropPath,
    required this.first_air_date,
    required this.genreIds,
    required this.id,
    required this.original_name,
    required this.name,
    required this.original_language,
    required this.overview,
    required this.popularity,
    required this.poster_path,
    required this.voteAverage,
    required this.voteCount
  });

  final String? backdropPath;
  final String? first_air_date;
  final List<int> genreIds;
  final int id;
  final String? original_name;
  final String? name;
  final String? original_language;
  final String overview;
  final double popularity;
  final String? poster_path;
  final double voteAverage;
  final int? voteCount;

  factory TVModel.fromJson(Map<String, dynamic> json) => TVModel(
        backdropPath: json["backdropPath"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        first_air_date:json["first_air_date"],
        name: json["name"],
        original_language: json["original_language"],
        original_name: json["original_name"],
        poster_path: json["poster_path"]
      );

  Map<String, dynamic> toJson() => {
        "backdropPath": backdropPath,
        "genreIds": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "overview": overview,
        "popularity": popularity,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "first_air_date":first_air_date,
        "name":name,
        "original_language":original_language,
        "original_name":original_name,
        "poster_path":poster_path,
      };

  TV toEntity() {
    return TV(
      backdropPath: this.backdropPath,
      genreIds: this.genreIds,
      id: this.id,
      overview: this.overview,
      popularity: this.popularity,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
      poster_path: this.poster_path,
      original_name: this.original_name,
      original_language: this.original_language,
      name: this.name,
      first_air_date: this.first_air_date
    );
  }

  @override
  List<Object?> get props => [
        backdropPath,
        genreIds,
        id,
        overview,
        popularity,
        voteAverage,
        voteCount,
        first_air_date,
        name,
        original_language,
        poster_path,
        original_name
      ];
}

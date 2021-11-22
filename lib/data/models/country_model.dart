import 'package:ditonton/domain/entities/country.dart';
import 'package:equatable/equatable.dart';

class CountryModel extends Equatable {
  CountryModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  Country toEntity() {
    return Country(id: this.id, name: this.name);
  }

  @override
  List<Object?> get props => [id, name];
}

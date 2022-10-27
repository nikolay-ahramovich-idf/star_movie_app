import 'package:floor/floor.dart';

@Entity(primaryKeys: ['id'])
class Movie {
  final int id;
  final String? title;
  final double? rating;
  final int? runtime;
  final String? certification;
  final String? overview;
  final String? imdbId;
  final int? tmdbId;
  final int moviesType;

  Movie({
    required this.id,
    this.title,
    this.rating,
    this.runtime,
    this.certification,
    this.overview,
    this.imdbId,
    this.tmdbId,
    required this.moviesType,
  });
}

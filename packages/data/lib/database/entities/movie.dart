import 'package:floor/floor.dart';

@entity
class Movie {
  @PrimaryKey(autoGenerate: true)
  int? id;

  final String? title;
  final double? rating;
  final int? runtime;
  final String? certification;
  final String? overview;
  final int? traktId;
  final String? imdbId;
  final int? tmdbId;
  final int movieType;

  Movie(
    this.title,
    this.rating,
    this.runtime,
    this.certification,
    this.overview,
    this.traktId,
    this.imdbId,
    this.tmdbId,
    this.movieType,
  );
}

import 'package:floor/floor.dart';

@entity
class MovieCharacter {
  @PrimaryKey(autoGenerate: true)
  int? id;

  final String characterName;
  final String actorName;
  final int tmdbId;
  final String? posterPath;
  final int movieId;

  MovieCharacter({
    this.id,
    required this.characterName,
    required this.actorName,
    required this.tmdbId,
    this.posterPath,
    required this.movieId,
  });
}

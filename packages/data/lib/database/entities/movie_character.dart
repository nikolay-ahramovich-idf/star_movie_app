import 'package:data/database/entities/movie.dart';
import 'package:floor/floor.dart';

@entity
class MovieCharacter {
  @PrimaryKey(autoGenerate: true)
  int? id;

  final String characterName;
  final String actorName;
  final int tmdbId;
  final String? posterPath;

  @ForeignKey(
    childColumns: ['owner_id'],
    parentColumns: ['traktId'],
    entity: Movie,
    onDelete: ForeignKeyAction.cascade,
  )
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

import 'package:data/database/entities/movie.dart';
import 'package:floor/floor.dart';

@entity
class Genre {
  @PrimaryKey(autoGenerate: true)
  int? id;

  @ForeignKey(
    childColumns: ['owner_id'],
    parentColumns: ['id'],
    entity: Movie,
  )
  @ColumnInfo(name: 'movie_id')
  final int movieId;

  final String name;

  Genre(
    this.movieId,
    this.name,
  );
}

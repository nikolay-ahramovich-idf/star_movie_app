import 'package:domain/entities/db/movie.dart';
import 'package:floor/floor.dart';

@Entity(
  foreignKeys: [
    ForeignKey(
      childColumns: ['movieId'],
      parentColumns: ['id'],
      entity: Movie,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class Genre {
  @PrimaryKey(autoGenerate: true)
  int? id;

  final String name;
  final int movieId;

  Genre({
    this.id,
    required this.name,
    required this.movieId,
  });
}

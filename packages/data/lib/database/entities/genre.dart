import 'package:data/database/entities/movie.dart';
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

  final int movieId;

  final String name;

  Genre({
    this.id,
    required this.movieId,
    required this.name,
  });
}

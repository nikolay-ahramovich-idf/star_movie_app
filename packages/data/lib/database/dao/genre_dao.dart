import 'package:data/database/entities/genre.dart';
import 'package:floor/floor.dart';

@dao
abstract class GenreDao {
  @Query('SELECT * FROM Genre WHERE movieId = :movieId')
  Future<List<Genre>> findMovieGenres(int movieId);

  @insert
  Future<void> insertGenres(List<Genre> genres);
}

import 'package:domain/entities/db/genre.dart';
import 'package:floor/floor.dart';

@dao
abstract class GenreDao {
  @Query('SELECT * FROM Genre WHERE movieId IN (:moviesIds)')
  Future<List<Genre>> findMoviesGenres(List<int> moviesIds);

  @insert
  Future<void> insertGenres(List<Genre> genres);
}

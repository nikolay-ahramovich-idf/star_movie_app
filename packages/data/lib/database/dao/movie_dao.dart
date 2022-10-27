import 'package:domain/entities/db/movie.dart';
import 'package:floor/floor.dart';

@dao
abstract class MovieDao {
  @Query('SELECT * FROM Movie WHERE moviesType = :movieType')
  Future<List<Movie>> findMoviesByType(int movieType);

  @Query('DELETE FROM Movie WHERE id in (:ids)')
  Future<void> deleteMoviesWithIds(List<int> ids);

  @insert
  Future<void> insertMovies(List<Movie> movies);
}

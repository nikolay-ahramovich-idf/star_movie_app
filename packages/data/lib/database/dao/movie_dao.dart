import 'package:data/database/entities/movie.dart';
import 'package:floor/floor.dart';

@dao
abstract class MovieDao {
  @Query('SELECT * FROM Movie WHERE moviesType = :movieType')
  Future<List<Movie>> findMoviesByType(int movieType);

  @Query('DELETE FROM Movie WHERE moviesType = :movieType')
  Future<void> deleteAllMoviesByType(int movieType);

  @insert
  Future<int> insertMovie(Movie movie);
}

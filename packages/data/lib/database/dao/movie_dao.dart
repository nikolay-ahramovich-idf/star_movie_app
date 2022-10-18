import 'package:data/database/entities/movie.dart';
import 'package:floor/floor.dart';

@dao
abstract class MovieDao {
  @Query('SELECT * FROM Movie WHERE movie_type = :movieType')
  Future<List<Movie>> findMoviesByType(int movieType);

  @insert
  Future<int> insertMovie(Movie movie);
}

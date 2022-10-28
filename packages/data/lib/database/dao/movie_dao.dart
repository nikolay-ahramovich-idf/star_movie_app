import 'package:domain/entities/db/genre.dart';
import 'package:domain/entities/db/movie.dart';
import 'package:floor/floor.dart';

@dao
abstract class MovieDao {
  @Query('SELECT * FROM Movie WHERE moviesType = :movieType')
  Future<List<Movie>> findMoviesByType(int movieType);

  @Query('DELETE FROM Movie WHERE id in (:ids)')
  Future<void> deleteMoviesWithIds(List<int> ids);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertMovies(List<Movie> movies);

  @insert
  Future<void> insertGenres(List<Genre> genres);

  @transaction
  Future<void> insertMoviesWithGenres(
    List<Movie> movies,
    List<Genre> genres,
  ) async {
    await insertMovies(movies);
    await insertGenres(genres);
  }
}

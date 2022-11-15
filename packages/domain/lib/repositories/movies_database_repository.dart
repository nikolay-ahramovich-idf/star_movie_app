import 'package:domain/entities/base_movie_entity.dart';
import 'package:domain/entities/db/genre.dart';
import 'package:domain/entities/db/movie.dart';
import 'package:domain/entities/db/movie_character.dart';

abstract class MoviesDatabaseRepository {
  Future<List<Movie>> getMovies(MoviesType movieType);

  Future<void> addMovies(
    List<Movie> movies,
    List<Genre> genres,
  );

  Future<void> removeMoviesWithIds(List<int> movieIds);

  Future<List<Genre>> getGenres(
    List<int> movieIds,
  );

  Future<List<MovieCharacter>> getCastAndCrew(int movieId);

  Future<void> addCastAndCrew(List<MovieCharacter> cast);
}

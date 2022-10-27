import 'package:domain/entities/base_movie_entity.dart';
import 'package:domain/entities/movie_character_entity.dart';

abstract class MoviesDatabaseRepository {
  Future<List<BaseMovieEntity>> getMovies(MoviesType movieType);

  Future<void> addMovies(
    List<BaseMovieEntity> movies,
    MoviesType moviesType,
  );

  Future<void> removeMoviesWithIds(List<int> movieIds);

  Future<List<MovieCharacterEntity>> getCast(int movieId);

  Future<void> addCast(
    int movieId,
    List<MovieCharacterEntity> cast,
  );
}

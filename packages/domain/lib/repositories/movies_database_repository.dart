import 'package:domain/entities/base_movie_entity.dart';
import 'package:domain/entities/movie_character_entity.dart';

abstract class MoviesDatabaseRepository {
  Future<List<BaseMovieEntity>> getMovies(MovieType movieType);

  Future<void> addMovies(
    List<BaseMovieEntity> movies,
    MovieType moviesType,
  );

  Future<void> removeMovies(MovieType movieType);

  Future<List<MovieCharacterEntity>> getCast(int movieId);

  Future<void> addCast(
    int movieId,
    List<MovieCharacterEntity> cast,
  );

  Future<void> removeCastExceptWithIds(List<int> movieIds);
}

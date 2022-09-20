import 'package:domain/entities/base_movie_entity.dart';
import 'package:domain/entities/movie_character_entity.dart';

abstract class MoviesRepository {
  Future<List<BaseMovieEntity>> getNowShowingMovies();
  Future<List<BaseMovieEntity>> getComingSoonMovies();
  Future<Iterable<MovieCharacterEntity>> getCast(int movieId);
}

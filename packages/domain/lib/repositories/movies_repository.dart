import 'package:domain/entities/movies_response_entity.dart';
import 'package:domain/entities/base_movie_entity.dart';
import 'package:domain/entities/movie_character_entity.dart';

abstract class MoviesRepository {
  Future<MoviesResponseEntity> getNowShowingMovies([
    Map<String, dynamic> queryParameters,
  ]);
  
  Future<MoviesResponseEntity> getComingSoonMovies([
    Map<String, dynamic> queryParameters,
  ]);

  Future<Iterable<dynamic>> getCast(int movieId);
}

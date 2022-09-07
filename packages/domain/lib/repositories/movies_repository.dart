import 'package:domain/entities/base_movie_entity.dart';

abstract class MoviesRepository {
  Future<List<BaseMovieEntity>> getNowShowingMovies();
  Future<List<BaseMovieEntity>> getComingSoonMovies();
}

import 'package:domain/entities/base_movie_entity.dart';

abstract class MoviesDatabaseRepository {
  Future<List<BaseMovieEntity>> getMovies(MovieType movieType);

  Future<void> addMovies(
    List<BaseMovieEntity> movies,
    MovieType moviesType,
  );
}

import 'package:domain/entities/base_movie_entity.dart';
import 'package:domain/repositories/movies_repository.dart';
import 'package:domain/usecases/usecase.dart';

class GetComingSoonMoviesUseCase extends UseCase<Future<List<BaseMovieEntity>>> {
  final MoviesRepository _moviesRepository;

  GetComingSoonMoviesUseCase(this._moviesRepository);

  @override
  Future<List<BaseMovieEntity>> call() {
    return _moviesRepository.getComingSoonMovies();
  }
}

import 'package:domain/entities/base_movie_entity.dart';
import 'package:domain/repositories/movies_repository.dart';
import 'package:domain/usecases/usecase.dart';

class GetNowShowingMoviesUseCase extends UseCase<Future<List<BaseMovieEntity>>> {
  final MoviesRepository _movieRepository;

  GetNowShowingMoviesUseCase(this._movieRepository);

  @override
  Future<List<BaseMovieEntity>> call() async {
    return await _movieRepository.getNowShowingMovies();
  }
}

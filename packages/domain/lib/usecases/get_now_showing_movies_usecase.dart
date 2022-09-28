import 'package:domain/entities/base_movie_entity.dart';
import 'package:domain/repositories/movies_repository.dart';
import 'package:domain/usecases/get_movies_base_usecase.dart';

class GetNowShowingMoviesUseCase extends GetMoviesBaseUsecase {
  final MoviesRepository _moviesRepository;

  GetNowShowingMoviesUseCase(this._moviesRepository);

  @override
  Future<List<BaseMovieEntity>> call() async {
    return await getMovies(
      _moviesRepository.getNowShowingMovies,
    );
  }
}

import 'package:domain/entities/base_movie_entity.dart';
import 'package:domain/repositories/movies_database_repository.dart';
import 'package:domain/repositories/movies_repository.dart';
import 'package:domain/services/app_interaction_service.dart';
import 'package:domain/usecases/get_movies_base_usecase.dart';

class GetComingSoonMoviesUseCase extends GetMoviesBaseUsecase {
  final AppInteractionService _appInteractionService;
  final MoviesRepository _moviesRepository;

  GetComingSoonMoviesUseCase(
    this._appInteractionService,
    this._moviesRepository,
    MoviesDatabaseRepository moviesDatabaseRepository,
  ) : super(moviesDatabaseRepository);

  @override
  Future<List<BaseMovieEntity>> call() async {
    final lastAppInteractionTime =
        await _appInteractionService.getLastAppInteractionTime(
      AppInteractionType.comingSoonMovies,
    );

    return await getMovies(
      _moviesRepository.getComingSoonMovies,
      MoviesType.comingSoon,
      lastAppInteractionTime,
    );
  }
}

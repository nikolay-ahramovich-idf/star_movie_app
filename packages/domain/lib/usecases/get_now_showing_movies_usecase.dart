import 'package:domain/entities/base_movie_entity.dart';
import 'package:domain/extensions/date_helpers.dart';
import 'package:domain/repositories/movies_database_repository.dart';
import 'package:domain/repositories/movies_repository.dart';
import 'package:domain/services/app_interaction_service.dart';
import 'package:domain/usecases/get_movies_base_usecase.dart';
import 'package:flutter/foundation.dart';

class GetNowShowingMoviesUseCase extends GetMoviesBaseUsecase {
  final AppInteractionService _appInteractionService;
  final MoviesRepository _moviesRepository;
  final MoviesDatabaseRepository _moviesDatabaseRepository;

  GetNowShowingMoviesUseCase(
    this._appInteractionService,
    this._moviesRepository,
    this._moviesDatabaseRepository,
  );

  @override
  Future<List<BaseMovieEntity>> call() async {
    final lastAppInteractionTime =
        await _appInteractionService.getLastAppInteractionTime();

    if (lastAppInteractionTime == null) {
      final movies = await getMovies(_moviesRepository.getNowShowingMovies);
      await _moviesDatabaseRepository.addMovies(movies, MovieType.nowShowing);

      return movies;
    }

    if (!lastAppInteractionTime.isToday) {
      final movies = await getMovies(_moviesRepository.getNowShowingMovies);

      final moviesFromDatabase = await _moviesDatabaseRepository.getMovies(
        MovieType.nowShowing,
      );
      if (!listEquals(movies, moviesFromDatabase)) {
        // TODO add remove to DAO
        await _moviesDatabaseRepository.addMovies(
          movies,
          MovieType.nowShowing,
        );
      }

      return movies;
    }

    return await _moviesDatabaseRepository.getMovies(MovieType.nowShowing);
  }
}

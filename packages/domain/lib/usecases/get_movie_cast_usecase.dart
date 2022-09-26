import 'package:domain/entities/movie_character_entity.dart';
import 'package:domain/repositories/images_repository.dart';
import 'package:domain/repositories/movies_repository.dart';
import 'package:domain/usecases/usecase.dart';

class GetMovieCastUsecaseParams {
  final int movieId;
  final int maxNumberOfActors;

  GetMovieCastUsecaseParams(
    this.movieId,
    this.maxNumberOfActors,
  );
}

class GetMovieCastUsecase extends UseCaseParams<GetMovieCastUsecaseParams,
    Future<Iterable<MovieCharacterEntity>>> {
  final MoviesRepository _moviesRepository;
  final ImagesRepository _imagesRepository;

  GetMovieCastUsecase(
    this._moviesRepository,
    this._imagesRepository,
  );

  @override
  Future<Iterable<MovieCharacterEntity>> call(
    GetMovieCastUsecaseParams params,
  ) async {
    final cast = await _moviesRepository.getCast(params.movieId);

    final updatingCastWithPosters = cast
        .where(
          (castItem) => List<dynamic>.from(castItem['characters']).isNotEmpty,
        )
        .map(
          (castItem) => MovieCharacterEntity.fromJson(
            castItem,
          ),
        )
        .take(
          params.maxNumberOfActors,
        )
        .map(
      (actor) async {
        final posterPath = await _imagesRepository.getActorPictureById(
          actor.tmdbId,
        );

        return posterPath != null
            ? actor.updatePosterPath(
                posterPath,
              )
            : actor;
      },
    );

    return await Future.wait(updatingCastWithPosters);
  }
}

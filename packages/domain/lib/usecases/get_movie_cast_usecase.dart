import 'package:domain/const.dart';
import 'package:domain/entities/movie_character_entity.dart';
import 'package:domain/repositories/images_repository.dart';
import 'package:domain/repositories/movies_database_repository.dart';
import 'package:domain/repositories/movies_repository.dart';
import 'package:domain/usecases/usecase.dart';

class GetMovieCastUseCaseParams {
  final int movieId;
  final int maxNumberOfActors;

  GetMovieCastUseCaseParams(
    this.movieId,
    this.maxNumberOfActors,
  );
}

class GetMovieCastUseCase extends UseCaseParams<GetMovieCastUseCaseParams,
    Future<List<MovieCharacterEntity>>> {
  final MoviesRepository _moviesRepository;
  final MoviesDatabaseRepository _moviesDatabaseRepository;
  final ImagesRepository _imagesRepository;

  GetMovieCastUseCase(
    this._moviesRepository,
    this._moviesDatabaseRepository,
    this._imagesRepository,
  );

  @override
  Future<List<MovieCharacterEntity>> call(
    GetMovieCastUseCaseParams params,
  ) async {
    final cachedCast = await _moviesDatabaseRepository.getCast(params.movieId);

    if (cachedCast.isEmpty) {
      final castResponse = await _moviesRepository.getCast(params.movieId);

      final updatingCastWithPosters = castResponse.cast
          .where((castItem) =>
              List<String>.from(castItem['characters']).isNotEmpty)
          .map((castItem) => MovieCharacterEntity.fromJson(castItem))
          .take(params.maxNumberOfActors)
          .map((actor) async {
        final actorProfiles =
            await _imagesRepository.getActorsProfiles(actor.tmdbId);

        actorProfiles?.sort(((a, b) => a['height'].compareTo(b['height'])));

        final posterPath =
            _getActorProfileUrl(actorProfiles?.first['file_path']);

        return posterPath != null ? actor.updatePosterPath(posterPath) : actor;
      });

      final cast = await Future.wait(updatingCastWithPosters);

      await _moviesDatabaseRepository.addCast(params.movieId, cast);

      return cast;
    }

    return cachedCast;
  }

  String? _getActorProfileUrl(String? filePath) {
    return filePath == null
        ? null
        : '${TMDBConfig.actorPictureApiPath}$filePath';
  }
}

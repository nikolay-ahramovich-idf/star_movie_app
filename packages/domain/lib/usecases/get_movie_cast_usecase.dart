import 'package:domain/const.dart';
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

class GetMovieCastUseCase extends UseCaseParams<GetMovieCastUsecaseParams,
    Future<List<MovieCharacterEntity>>> {
  final MoviesRepository _moviesRepository;
  final ImagesRepository _imagesRepository;

  GetMovieCastUseCase(
    this._moviesRepository,
    this._imagesRepository,
  );

  @override
  Future<List<MovieCharacterEntity>> call(
    GetMovieCastUsecaseParams params,
  ) async {
    final cast = await _moviesRepository.getCast(params.movieId);

    final updatingCastWithPosters = cast
        .where(
            (castItem) => List<dynamic>.from(castItem['characters']).isNotEmpty)
        .map((castItem) => MovieCharacterEntity.fromJson(castItem))
        .take(params.maxNumberOfActors)
        .map((actor) async {
      final actorProfiles =
          await _imagesRepository.getActorsProfiles(actor.tmdbId);

      actorProfiles?.sort(((a, b) => a['height'].compareTo(b['height'])));

      final posterPath = _getActorProfileUrl(actorProfiles?.first['file_path']);

      return posterPath != null ? actor.updatePosterPath(posterPath) : actor;
    });

    return await Future.wait(updatingCastWithPosters);
  }

  String? _getActorProfileUrl(String? filePath) {
    return filePath == null
        ? null
        : '${TMDBConfig.actorPictureApiPath}$filePath';
  }
}

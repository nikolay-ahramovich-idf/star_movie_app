import 'package:domain/const.dart';
import 'package:domain/entities/db/movie_character.dart';
import 'package:domain/entities/movie_character_entity.dart';
import 'package:domain/repositories/images_repository.dart';
import 'package:domain/repositories/movies_database_repository.dart';
import 'package:domain/repositories/movies_repository.dart';
import 'package:domain/usecases/usecase.dart';

class GetMovieCastCrewUseCase
    extends UseCaseParams<int, Future<List<MovieCharacterEntity>>> {
  final MoviesRepository _moviesRepository;
  final MoviesDatabaseRepository _moviesDatabaseRepository;
  final ImagesRepository _imagesRepository;

  GetMovieCastCrewUseCase(
    this._moviesRepository,
    this._moviesDatabaseRepository,
    this._imagesRepository,
  );

  @override
  Future<List<MovieCharacterEntity>> call(
    int params,
  ) async {
    final cachedCastAndCrew =
        await _moviesDatabaseRepository.getCastAndCrew(params);

    if (cachedCastAndCrew.isEmpty) {
      final castAndCrewResponse =
          await _moviesRepository.getCastAndCrew(params);

      final updatingCastWithPosters = castAndCrewResponse.cast
          .where((castItem) =>
              List<String>.from(castItem['characters']).isNotEmpty)
          .map((castItem) => MovieCharacterEntity.fromJson(castItem))
          .map(_getPosterPath);

      final cast = await Future.wait(updatingCastWithPosters);

      final updatingCrewWithPosters = castAndCrewResponse.crew
          .where((crewItem) => List<String>.from(crewItem['jobs']).isNotEmpty)
          .map((crewItem) => MovieCharacterEntity.fromJson(crewItem))
          .map(_getPosterPath);

      final crew = await Future.wait(updatingCrewWithPosters);

      final cachedCastAndCrew = (cast + crew)
          .map(
            (castAndCrewItem) => _mapToMovieCharacter(
              castAndCrewItem,
              params,
            ),
          )
          .toList();

      await _moviesDatabaseRepository.addCastAndCrew(cachedCastAndCrew);

      return cast + crew;
    }

    return cachedCastAndCrew.map(_mapToMovieCharacterEntity).toList();
  }

  Future<MovieCharacterEntity> _getPosterPath(
      MovieCharacterEntity character) async {
    final employeeProfiles =
        await _imagesRepository.getActorsProfiles(character.tmdbId);

    employeeProfiles?.sort(((a, b) => a['height'].compareTo(b['height'])));

    if (employeeProfiles != null && employeeProfiles.isNotEmpty) {
      final posterPath =
          _getActorProfileUrl(employeeProfiles.first['file_path']);

      return posterPath != null
          ? character.updatePosterPath(posterPath)
          : character;
    }

    return character;
  }

  String? _getActorProfileUrl(String? filePath) {
    return filePath == null
        ? null
        : '${TMDBConfig.actorPictureApiPath}$filePath';
  }

  MovieCharacter _mapToMovieCharacter(
    MovieCharacterEntity castItem,
    int movieId,
  ) {
    return MovieCharacter(
      characterName: castItem.roleName,
      actorName: castItem.personName,
      tmdbId: castItem.tmdbId,
      posterPath: castItem.posterPath,
      movieId: movieId,
    );
  }

  MovieCharacterEntity _mapToMovieCharacterEntity(MovieCharacter castItem) {
    return MovieCharacterEntity(
      roleName: castItem.characterName,
      personName: castItem.actorName,
      tmdbId: castItem.tmdbId,
      posterPath: castItem.posterPath,
    );
  }
}

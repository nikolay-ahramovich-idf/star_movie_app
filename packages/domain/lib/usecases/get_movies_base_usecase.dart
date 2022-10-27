import 'package:domain/const.dart';
import 'package:domain/entities/base_movie_entity.dart';
import 'package:domain/entities/movies_response_entity.dart';
import 'package:domain/exceptions/movies_request_exception.dart';
import 'package:domain/extensions/date_helpers.dart';
import 'package:domain/repositories/movies_database_repository.dart';
import 'package:domain/usecases/usecase.dart';
import 'package:flutter/foundation.dart';

abstract class GetMoviesBaseUsecase
    implements UseCase<Future<Iterable<BaseMovieEntity>>> {
  final MoviesDatabaseRepository _moviesDatabaseRepository;

  GetMoviesBaseUsecase(this._moviesDatabaseRepository);

  Future<List<BaseMovieEntity>> getMovies(
    Future<MoviesResponseEntity> Function([Map<String, dynamic>])
        remoteMoviesGetter,
    MovieType moviesType,
    DateTime? lastInteractionTime,
  ) async {
    if (lastInteractionTime == null) {
      final movies = await _getRemoteMovies(remoteMoviesGetter);
      await _moviesDatabaseRepository.addMovies(
        movies,
        MovieType.nowShowing,
      );

      return movies;
    }

    final cachedMovies = await _moviesDatabaseRepository.getMovies(moviesType);

    if (cachedMovies.isEmpty || !lastInteractionTime.isToday) {
      final movies = await _getRemoteMovies(remoteMoviesGetter);

      if (!listEquals(
        movies,
        cachedMovies,
      )) {
        await _moviesDatabaseRepository.removeMovies(moviesType);

        final newMovieIds = movies.map((movie) => movie.traktId).toList();

        await _moviesDatabaseRepository.removeCastExceptWithIds(newMovieIds);

        await _moviesDatabaseRepository.addMovies(movies, moviesType);
      }

      return movies;
    }

    return cachedMovies;
  }

  Future<List<BaseMovieEntity>> _getRemoteMovies(
    Future<MoviesResponseEntity> Function([Map<String, dynamic>]) moviesGetter,
  ) async {
    try {
      final moviesResponse = await moviesGetter();

      final headers = moviesResponse.headers;
      final totalMoviesCount = int.parse(
        headers[TraktApiSpecialHeaders.totalMoviesCountHeader]?.first ?? '',
      );

      int additionalMoviesCount =
          totalMoviesCount >= TraktMovieCounts.maxMoviesCount
              ? TraktMovieCounts.maxAdditionalMoviesCount
              : TraktMovieCounts.minAdditionalMoviesCount;

      final paginationQueryParameters = <String, dynamic>{};
      paginationQueryParameters['page'] = 2;
      paginationQueryParameters['limit'] = additionalMoviesCount;

      final additionalMoviesResponse = await moviesGetter(
        paginationQueryParameters,
      );

      final resultMovies = [
        ...(moviesResponse.movies ?? []),
        ...(additionalMoviesResponse.movies ?? []),
      ];

      return resultMovies
          .map((movie) => BaseMovieEntity.fromJson(movie))
          .toList();
    } on MoviesRequestException catch (e) {
      print('Log: ${e.errorMessage}');
      return [];
    }
  }
}

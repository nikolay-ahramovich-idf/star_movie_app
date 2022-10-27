import 'package:domain/const.dart';
import 'package:domain/entities/base_movie_entity.dart';
import 'package:domain/entities/db/genre.dart';
import 'package:domain/entities/db/movie.dart';
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
    MoviesType moviesType,
    DateTime? lastInteractionTime,
  ) async {
    if (lastInteractionTime == null) {
      final remoteMovies = await _getRemoteMovies(remoteMoviesGetter);

      final movies = _mapToDatabaseMovies(remoteMovies, moviesType);
      final genres = _mapToDatabaseGenres(remoteMovies);

      await _moviesDatabaseRepository.addMovies(movies, genres);

      return remoteMovies;
    }

    final cachedMovies = (await _moviesDatabaseRepository.getMovies(moviesType))
        .map(_mapToMovieToEntity)
        .toList();

    if (cachedMovies.isEmpty || !lastInteractionTime.isToday) {
      final remoteMovies = await _getRemoteMovies(remoteMoviesGetter);

      if (!listEquals(
        remoteMovies,
        cachedMovies,
      )) {
        final movieIds = remoteMovies.map((movie) => movie.traktId).toSet();
        final cachedMovieIds = cachedMovies
            .map(
              (cachedMovie) => cachedMovie.traktId,
            )
            .toSet();

        final cachedMovieIdsToRemove =
            cachedMovieIds.difference(movieIds).toList();

        await _moviesDatabaseRepository
            .removeMoviesWithIds(cachedMovieIdsToRemove);

        final movieIdsToAdd = movieIds.difference(cachedMovieIds);

        final moviesToAdd = remoteMovies
            .where(
              (movie) => movieIdsToAdd.contains(
                movie.traktId,
              ),
            )
            .toList();

        final movies = _mapToDatabaseMovies(moviesToAdd, moviesType);
        final genres = _mapToDatabaseGenres(moviesToAdd);

        await _moviesDatabaseRepository.addMovies(
          movies,
          genres,
        );
      }

      return remoteMovies;
    }

    _updateMovieEntitiesWithGenres(cachedMovies);

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

  List<Movie> _mapToDatabaseMovies(
    List<BaseMovieEntity> movies,
    MoviesType moviesType,
  ) {
    return movies
        .map((movie) => Movie(
              id: movie.traktId,
              title: movie.title,
              rating: movie.rating,
              runtime: movie.runtime,
              certification: movie.certification,
              overview: movie.overview,
              imdbId: movie.imdbId,
              tmdbId: movie.tmdbId,
              moviesType: moviesType.index,
            ))
        .toList();
  }

  List<Genre> _mapToDatabaseGenres(List<BaseMovieEntity> movies) {
    final List<Genre> genres = [];

    for (final movie in movies) {
      genres.addAll(movie.genres
              ?.map((genre) => Genre(
                    movieId: movie.traktId,
                    name: genre,
                  ))
              .toList() ??
          []);
    }

    return genres;
  }

  BaseMovieEntity _mapToMovieToEntity(Movie movie) {
    return BaseMovieEntity(
      movie.title,
      rating: movie.rating,
      runtime: movie.runtime,
      certification: movie.certification,
      overview: movie.overview,
      traktId: movie.id,
      imdbId: movie.imdbId,
      tmdbId: movie.tmdbId,
    );
  }

  Future<void> _updateMovieEntitiesWithGenres(
      List<BaseMovieEntity> movies) async {
    final moviesIds = movies.map((movie) => movie.traktId).toList();
    final genres = await _moviesDatabaseRepository.getGenres(moviesIds);

    for (final movie in movies) {
      final movieGenres = genres
          .where((genre) => genre.id == movie.traktId)
          .map((genre) => genre.name)
          .toList();

      movie.genres = movieGenres;
    }
  }
}

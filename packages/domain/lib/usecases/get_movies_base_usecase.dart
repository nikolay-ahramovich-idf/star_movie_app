import 'package:domain/const.dart';
import 'package:domain/entities/base_movie_entity.dart';
import 'package:domain/entities/movies_response_entity.dart';
import 'package:domain/usecases/usecase.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

abstract class GetMoviesBaseUsecase
    implements UseCase<Future<Iterable<BaseMovieEntity>>> {
  @protected
  Future<List<BaseMovieEntity>> getMovies(
      Future<MoviesResponseEntity> Function([Map<String, dynamic>])
          moviesGetter) async {
    final moviesResponse = await moviesGetter();

    if (moviesResponse.errorMessage != null) {
      print('Log: ${moviesResponse.errorMessage}');
      return [];
    }

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
  }
}

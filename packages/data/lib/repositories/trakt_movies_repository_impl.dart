import 'package:dio/dio.dart';
import 'package:data/const.dart';
import 'package:data/services/api_base_service.dart';
import 'package:domain/entities/base_movie_entity.dart';
import 'package:domain/repositories/movies_repository.dart';

class TraktMoviesRepositoryImpl implements MoviesRepository {
  final ApiBaseService _traktApiService;

  TraktMoviesRepositoryImpl(this._traktApiService);

  @override
  Future<List<BaseMovieEntity>> getNowShowingMovies() async {
    return await _getMovies(TraktApiPaths.nowShowingMovies);
  }

  @override
  Future<List<BaseMovieEntity>> getComingSoonMovies() async {
    return await _getMovies(TraktApiPaths.comingSoonMovies);
  }

  Future<List<BaseMovieEntity>> _getMovies(String moviesUrl) async {
    final moviesResponse = await _traktApiService.get<List<dynamic>>(
      moviesUrl,
      queryParameters: TraktApiPathsQueryParameters.extendedQuery,
    );

    final headers = moviesResponse.headers;
    final totalMoviesCount = int.parse(
        headers[TraktApiSpecialHeaders.totalMoviesCountHeader]?.first ?? '');

    int additionalMoviesCount =
        totalMoviesCount >= TraktMovieCounts.maxMoviesCount
            ? TraktMovieCounts.maxAdditionalMoviesCount
            : TraktMovieCounts.minAdditionalMoviesCount;

    final paginationQueryParameters = <String, dynamic>{};
    paginationQueryParameters
        .addAll(TraktApiPathsQueryParameters.extendedQuery);
    paginationQueryParameters['page'] = 2;
    paginationQueryParameters['limit'] = additionalMoviesCount;

    final additionalMoviesResponse =
        await _traktApiService.get<List<dynamic>>(
      moviesUrl,
      queryParameters: paginationQueryParameters,
    );

    final resultMovies = [
      ...(moviesResponse.data?.toList() ?? []),
      ...(additionalMoviesResponse.data?.toList() ?? [])
    ];

    return resultMovies.map((m) => BaseMovieEntity.fromJson(m)).toList();
  }
}

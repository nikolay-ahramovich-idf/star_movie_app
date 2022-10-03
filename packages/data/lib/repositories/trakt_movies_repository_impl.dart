import 'package:data/const.dart';
import 'package:data/services/api_base_service.dart';
import 'package:dio/dio.dart';
import 'package:domain/entities/cast_response_entity.dart';
import 'package:domain/entities/movies_response_entity.dart';
import 'package:domain/exceptions/movies_request_exception.dart';
import 'package:domain/repositories/movies_repository.dart';

class TraktMoviesRepositoryImpl implements MoviesRepository {
  final ApiBaseService _traktApiService;

  TraktMoviesRepositoryImpl(this._traktApiService);

  @override
  Future<MoviesResponseEntity> getNowShowingMovies([
    Map<String, dynamic> queryParameters = const {},
  ]) async {
    final moviesResponse =
        await _getMovies(TraktApiPaths.nowShowingMovies, queryParameters);

    return moviesResponse;
  }

  @override
  Future<MoviesResponseEntity> getComingSoonMovies([
    Map<String, dynamic> queryParameters = const {},
  ]) async {
    return await _getMovies(TraktApiPaths.comingSoonMovies, queryParameters);
  }

  @override
  Future<CastResponseEntity> getCast(int movieId) async {
    final peopleApiUri = _getPeopleApiUri(movieId);

    final peopleResponse =
        await _traktApiService.get<Map<String, dynamic>>(peopleApiUri);

    return CastResponseEntity.fromJson(peopleResponse.data ?? {});
  }

  Future<MoviesResponseEntity> _getMovies(
    String moviesUrl,
    Map<String, dynamic> queryParameters,
  ) async {
    final fullQueryParameters = {
      ...TraktApiPathsQueryParameters.extendedQuery,
      ...queryParameters,
    };

    try {
      final moviesResponse = await _traktApiService.get<List<dynamic>>(
        moviesUrl,
        queryParameters: fullQueryParameters,
      );

      return MoviesResponseEntity(
        moviesResponse.data,
        headers: moviesResponse.headers.map,
      );
    } on DioError catch (e) {
      throw MoviesRequestException(e.message);
    }
  }

  String _getPeopleApiUri(int id) {
    return '/movies/$id/people';
  }
}

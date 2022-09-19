import 'package:data/const.dart';
import 'package:data/services/api_base_service.dart';
import 'package:domain/entities/movies_response_entity.dart';
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

  Future<MoviesResponseEntity> _getMovies(
    String moviesUrl,
    Map<String, dynamic> queryParameters,
  ) async {
    final fullQueryParameters = {
      ...TraktApiPathsQueryParameters.extendedQuery,
      ...queryParameters,
    };

    final moviesResponse = await _traktApiService.get<List<dynamic>>(
      moviesUrl,
      queryParameters: fullQueryParameters,
    );

    return MoviesResponseEntity(
      moviesResponse.data,
      headers: moviesResponse.headers.map,
    );
  }
}

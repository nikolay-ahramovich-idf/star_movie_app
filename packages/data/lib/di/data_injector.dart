import 'package:data/const.dart';
import 'package:data/repositories/trakt_movies_repository_impl.dart';
import 'package:data/services/api_base_service.dart';
import 'package:dio/dio.dart';
import 'package:domain/repositories/movies_repository.dart';
import 'package:get_it/get_it.dart';

void initDataInjector() {
  _initTractApiService();
}

void _initTractApiService() {
  GetIt.I.registerSingleton<Dio>(_buildDioForTractApi());
  GetIt.I.registerSingleton<ApiBaseService>(ApiServiceImpl(GetIt.I.get<Dio>()));
  GetIt.I.registerSingleton<MoviesRepository>(
      TraktMoviesRepositoryImpl(GetIt.I.get<ApiBaseService>()));
}

Dio _buildDioForTractApi() {
  final dioOptions = BaseOptions(
    baseUrl: TraktApiConfig.apiPath,
    headers: TraktApiConfig.apiHeaders,
  );

  return Dio(dioOptions);
}

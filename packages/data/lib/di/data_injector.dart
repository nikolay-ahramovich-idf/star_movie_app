import 'package:get_it/get_it.dart';
import 'package:data/repositories/tmdb_images_repository_impl.dart';
import 'package:data/const.dart';
import 'package:data/repositories/trakt_movies_repository_impl.dart';
import 'package:data/services/api_base_service.dart';
import 'package:data/services/app_config_service.dart';
import 'package:dio/dio.dart';
import 'package:domain/repositories/images_repository.dart';
import 'package:domain/repositories/movies_repository.dart';

Future<void> initDataInjector() async {
  _initAppConfigService();
  await _initTractApiService();
  await _initTMDBApiService();
  _initMoviesRepository();
  await _initImagesRepository();
}

void _initAppConfigService() {
  GetIt.I.registerSingleton<AppConfigService>(AppConfigServiceImpl());
}

Future<void> _initTractApiService() async {
  final traktApiKey =
      await _getConfigValue<String>(TraktApiConfig.traktApiKeyJsonConfigName);

  GetIt.I.registerSingleton<Dio>(
    _buildDioForTractApi(traktApiKey),
    instanceName: DISingletonInstanceNames.traktApiDio,
  );

  GetIt.I.registerSingleton<ApiBaseService>(
    ApiServiceImpl(
      GetIt.I.get<Dio>(
        instanceName: DISingletonInstanceNames.traktApiDio,
      ),
    ),
    instanceName: DISingletonInstanceNames.traktApiService,
  );
}

Future<void> _initTMDBApiService() async {
  final tmdbApiKey =
      await _getConfigValue<String>(TMDBConfig.tmdbApiKeyJsonConfigName);

  GetIt.I.registerSingleton<Dio>(
    _buildDioForTMDBApi(tmdbApiKey),
    instanceName: DISingletonInstanceNames.tmdbApiDio,
  );

  GetIt.I.registerSingleton<ApiBaseService>(
    ApiServiceImpl(
      GetIt.I.get<Dio>(
        instanceName: DISingletonInstanceNames.tmdbApiDio,
      ),
    ),
    instanceName: DISingletonInstanceNames.tmdbApiService,
  );
}

void _initMoviesRepository() {
  GetIt.I.registerSingleton<MoviesRepository>(
    TraktMoviesRepositoryImpl(
      GetIt.I.get<ApiBaseService>(
        instanceName: DISingletonInstanceNames.traktApiService,
      ),
    ),
  );
}

Future<void> _initImagesRepository() async {
  GetIt.I.registerSingleton<ImagesRepository>(
    TMDBImagesRepository(
      GetIt.I.get<ApiBaseService>(
        instanceName: DISingletonInstanceNames.tmdbApiService,
      ),
    ),
  );
}

Dio _buildDioForTractApi(String traktApiKey) {
  final dioOptions = BaseOptions(
    baseUrl: TraktApiConfig.apiPath,
    headers: {
      ...TraktApiConfig.apiHeaders,
      ...{
        TraktApiConfig.traktApiKeyHeaderName: traktApiKey,
      }
    },
  );

  return Dio(dioOptions);
}

Dio _buildDioForTMDBApi(String tmdbApiKey) {
  final didOptions = BaseOptions(baseUrl: TMDBConfig.apiPath, queryParameters: {
    TMDBConfig.tmdbApiKeyQueryName: tmdbApiKey,
  });

  return Dio(didOptions);
}

Future<S> _getConfigValue<S>(String key) async {
  final appConfigService = GetIt.I.get<AppConfigService>();
  final value = (await appConfigService.getConfig())[key];

  return value as S;
}

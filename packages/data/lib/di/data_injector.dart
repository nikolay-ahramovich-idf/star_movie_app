import 'package:data/const.dart';
import 'package:data/repositories/firestore_repository.dart';
import 'package:data/repositories/tmdb_images_repository_impl.dart';
import 'package:data/repositories/trakt_movies_repository_impl.dart';
import 'package:data/services/api_base_service.dart';
import 'package:data/services/app_config_service_impl.dart';
import 'package:dio/dio.dart';
import 'package:domain/repositories/images_repository.dart';
import 'package:domain/repositories/movies_repository.dart';
import 'package:domain/repositories/remote_store_repository.dart';
import 'package:domain/services/app_config_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

Future<void> initDataInjector(
  String traktApiBaseUrl,
  String traktApiKeyConfigKey,
) async {
  await Firebase.initializeApp();
  _initAppConfigService();
  _initFirestoreService();
  await _initTractApiService(traktApiBaseUrl, traktApiKeyConfigKey);
  await _initTMDBApiService();
  _initMoviesRepository();
  _initImagesRepository();
}

void _initAppConfigService() {
  GetIt.I.registerSingleton<AppConfigService>(AppConfigServiceImpl());
}

Future<void> _initTractApiService(
  String traktApiBaseUrl,
  String traktApiKeyConfigKey,
) async {
  final appConfigService = GetIt.I.get<AppConfigService>();

  final traktApiKey =
      await appConfigService.getConfigValue<String>(traktApiKeyConfigKey);

  GetIt.I.registerSingleton<Dio>(
    _buildDioForTractApi(
      traktApiBaseUrl,
      traktApiKey,
    ),
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
  final appConfigService = GetIt.I.get<AppConfigService>();

  final tmdbApiKey = await appConfigService
      .getConfigValue<String>(TMDBConfig.tmdbApiKeyJsonConfigName);

  GetIt.I.registerSingleton<Dio>(
    _buildDioForTMDBApi(tmdbApiKey),
    instanceName: DISingletonInstanceNames.tmdbApiDio,
  );

  GetIt.I.registerSingleton<ApiBaseService>(
    ApiServiceImpl(
      GetIt.I.get<Dio>(instanceName: DISingletonInstanceNames.tmdbApiDio),
    ),
    instanceName: DISingletonInstanceNames.tmdbApiService,
  );
}

void _initMoviesRepository() {
  GetIt.I.registerSingleton<MoviesRepository>(
    TraktMoviesRepositoryImpl(
      GetIt.I.get<ApiBaseService>(
          instanceName: DISingletonInstanceNames.traktApiService),
    ),
  );
}

void _initImagesRepository() {
  GetIt.I.registerSingleton<ImagesRepository>(
    TMDBImagesRepository(
      GetIt.I.get<ApiBaseService>(
          instanceName: DISingletonInstanceNames.tmdbApiService),
    ),
  );
}

void _initFirestoreService() {
  GetIt.I.registerSingleton<RemoteStoreRepository>(FirestoreService());
}

Dio _buildDioForTractApi(
  String traktApiBaseUrl,
  String traktApiKey,
) {
  final dioOptions = BaseOptions(
    baseUrl: traktApiBaseUrl,
    headers: {TraktApiConfig.traktApiKeyHeaderName: traktApiKey},
  );

  return Dio(dioOptions);
}

Dio _buildDioForTMDBApi(String tmdbApiKey) {
  final didOptions = BaseOptions(
    baseUrl: TMDBConfig.apiPath,
    queryParameters: {TMDBConfig.tmdbApiKeyQueryName: tmdbApiKey},
  );

  return Dio(didOptions);
}

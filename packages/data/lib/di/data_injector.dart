import 'package:data/const.dart';
import 'package:data/repositories/auth_repository_impl.dart';
import 'package:data/repositories/credentials_repository_impl.dart';
import 'package:data/repositories/firestore_repository.dart';
import 'package:data/repositories/tmdb_images_repository_impl.dart';
import 'package:data/repositories/trakt_movies_repository_impl.dart';
import 'package:data/services/api_base_service.dart';
import 'package:data/services/app_config_service_impl.dart';
import 'package:data/services/facebook_auth_service.dart';
import 'package:data/services/google_auth_service.dart';
import 'package:dio/dio.dart';
import 'package:domain/repositories/auth_repository.dart';
import 'package:domain/repositories/credentials_repository.dart';
import 'package:domain/repositories/images_repository.dart';
import 'package:domain/repositories/movies_repository.dart';
import 'package:domain/repositories/remote_store_repository.dart';
import 'package:domain/services/app_config_service.dart';
import 'package:domain/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

Future<void> initDataInjector(
  String traktApiBaseUrl,
  String traktApiKeyConfigKey,
) async {
  await Firebase.initializeApp();
  _initAppConfigService();
  _initFirestoreRepository();
  await _initTractApiService(traktApiBaseUrl, traktApiKeyConfigKey);
  await _initTMDBApiService();
  _initMoviesRepository();
  _initImagesRepository();
  _initAuthServices();
  _initAuthRepository();
  _initCredentialsRepository();
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

void _initFirestoreRepository() {
  GetIt.I.registerSingleton<RemoteStoreRepository>(FirestoreRepository());
}

void _initAuthServices() {
  GetIt.I.registerSingleton<AuthService>(
    FacebookAuthService(),
    instanceName: DISingletonInstanceNames.facebookAuthService,
  );

  GetIt.I.registerSingleton<AuthService>(
    GoogleAuthService(),
    instanceName: DISingletonInstanceNames.googleAuthService,
  );
}

void _initAuthRepository() {
  GetIt.I.registerSingleton<AuthRepository>(AuthRepositoryImpl(
    GetIt.I.get<AuthService>(
        instanceName: DISingletonInstanceNames.facebookAuthService),
    GetIt.I.get<AuthService>(
        instanceName: DISingletonInstanceNames.googleAuthService),
  ));
}

void _initCredentialsRepository() {
  GetIt.I.registerSingleton<CredentialsRepository>(CredentialsRepositoryImpl());
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

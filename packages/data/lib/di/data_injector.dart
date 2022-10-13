import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/const.dart';
import 'package:data/repositories/auth_repository_impl.dart';
import 'package:data/repositories/credentials_repository_impl.dart';
import 'package:data/repositories/firestore_repository.dart';
import 'package:data/repositories/tmdb_images_repository_impl.dart';
import 'package:data/repositories/trakt_movies_repository_impl.dart';
import 'package:data/services/analytics_service_impl.dart';
import 'package:data/services/api_base_service.dart';
import 'package:data/services/app_config_service_impl.dart';
import 'package:data/services/facebook_auth_service.dart';
import 'package:data/services/google_auth_service.dart';
import 'package:data/services/share_movie_service_impl.dart';
import 'package:data/services/validation_service_impl.dart';
import 'package:dio/dio.dart';
import 'package:domain/repositories/auth_repository.dart';
import 'package:domain/repositories/credentials_repository.dart';
import 'package:domain/repositories/images_repository.dart';
import 'package:domain/repositories/movies_repository.dart';
import 'package:domain/repositories/remote_store_repository.dart';
import 'package:domain/services/analytics_service.dart';
import 'package:domain/services/app_config_service.dart';
import 'package:domain/services/auth_service.dart';
import 'package:domain/services/share_movie_service.dart';
import 'package:domain/services/validation_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:share_movie_plugin/share_movie_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initDataInjector(
  String traktApiBaseUrl,
  String traktApiKeyConfigKey,
) async {
  _initAppConfigService();
  _initFirestoreRepository();
  await _initTractApiService(
    traktApiBaseUrl,
    traktApiKeyConfigKey,
  );
  await _initTMDBApiService();
  _initMoviesRepository();
  _initImagesRepository();
  _initAuthServices();
  _initAuthRepository();
  await _initCredentialsRepository();
  _initAnalyticsService();
  _initShareMovieService();
  await _initValidationService();
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

  final tmdbApiKey = await appConfigService.getConfigValue<String>(
    TMDBConfig.tmdbApiKeyJsonConfigName,
  );

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

void _initImagesRepository() {
  GetIt.I.registerSingleton<ImagesRepository>(
    TMDBImagesRepository(
      GetIt.I.get<ApiBaseService>(
        instanceName: DISingletonInstanceNames.tmdbApiService,
      ),
    ),
  );
}

void _initFirestoreRepository() {
  GetIt.I.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);

  GetIt.I.registerSingleton<RemoteStoreRepository>(
    FirestoreRepository(
      GetIt.I.get<FirebaseFirestore>(),
    ),
  );
}

void _initAuthServices() {
  GetIt.I.registerSingleton<FacebookAuth>(FacebookAuth.instance);

  GetIt.I.registerSingleton<AuthService>(
    FacebookAuthService(
      GetIt.I.get<FacebookAuth>(),
    ),
    instanceName: DISingletonInstanceNames.facebookAuthService,
  );

  GetIt.I.registerSingleton<GoogleSignIn>(GoogleSignIn());

  GetIt.I.registerSingleton<AuthService>(
    GoogleAuthService(
      GetIt.I.get<GoogleSignIn>(),
    ),
    instanceName: DISingletonInstanceNames.googleAuthService,
  );
}

void _initAuthRepository() {
  GetIt.I.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      GetIt.I.get<AuthService>(
        instanceName: DISingletonInstanceNames.facebookAuthService,
      ),
      GetIt.I.get<AuthService>(
        instanceName: DISingletonInstanceNames.googleAuthService,
      ),
    ),
  );
}

Future<void> _initCredentialsRepository() async {
  GetIt.I.registerSingletonAsync<SharedPreferences>(
    () async => await SharedPreferences.getInstance(),
  );

  GetIt.I.registerSingleton<CredentialsRepository>(
    CredentialsRepositoryImpl(
      await GetIt.I.getAsync<SharedPreferences>(),
    ),
  );
}

void _initAnalyticsService() {
  GetIt.I.registerSingleton<FirebaseAnalytics>(FirebaseAnalytics.instance);

  GetIt.I.registerSingleton<AnalyticsService>(
    AnalyticsServiceImpl(
      GetIt.I.get<FirebaseAnalytics>(),
    ),
  );
}

void _initShareMovieService() {
  GetIt.I.registerSingleton<ShareMoviePlugin>(ShareMoviePlugin());

  GetIt.I.registerSingleton<ShareMovieService>(
    ShareMovieServiceImpl(GetIt.I.get<ShareMoviePlugin>()),
  );
}

Future<void> _initValidationService() async {
  final appConfigService = GetIt.I.get<AppConfigService>();

  final loginLength = await appConfigService.getConfigValue<int>(
    ValidationConfig.loginValidationRuleKeyJsonConfigName,
  );

  final passwordRegularExpression =
      await appConfigService.getConfigValue<String>(
    ValidationConfig.passwordValidationRuleKeyJsonConfigName,
  );

  GetIt.I.registerSingleton<ValidationService>(
    ValidationServiceImpl(
      loginLength,
      passwordRegularExpression,
    ),
  );
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

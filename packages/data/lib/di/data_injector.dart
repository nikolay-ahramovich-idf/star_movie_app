import 'package:data/services/app_config_service_impl.dart';
import 'package:domain/services/app_config_service.dart';
import 'package:get_it/get_it.dart';
import 'package:data/const.dart';
import 'package:data/repositories/trakt_movies_repository_impl.dart';
import 'package:data/services/api_base_service.dart';
import 'package:dio/dio.dart';
import 'package:domain/repositories/movies_repository.dart';

Future<void> initDataInjector() async {
  _initAppConfigService();
  await _initTractApiService();
  _initMoviesRepository();
}

void _initAppConfigService() {
  GetIt.I.registerSingleton<AppConfigService>(
    AppConfigServiceImpl(),
  );
}

Future<void> _initTractApiService() async {
  final appConfigService = GetIt.I.get<AppConfigService>();

  final traktApiKey = await appConfigService
      .getConfigValue<String>(TraktApiConfig.traktApiKeyJsonConfigName);

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

void _initMoviesRepository() {
  GetIt.I.registerSingleton<MoviesRepository>(
    TraktMoviesRepositoryImpl(
      GetIt.I.get<ApiBaseService>(
        instanceName: DISingletonInstanceNames.traktApiService,
      ),
    ),
  );
}

Dio _buildDioForTractApi(String traktApiKey) {
  final dioOptions = BaseOptions(
    baseUrl: TraktApiConfig.apiPath,
    headers: {
      TraktApiConfig.traktApiKeyHeaderName: traktApiKey,
    },
  );

  return Dio(dioOptions);
}

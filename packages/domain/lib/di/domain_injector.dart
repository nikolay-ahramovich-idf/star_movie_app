import 'package:domain/const.dart';
import 'package:domain/repositories/auth_repository.dart';
import 'package:domain/repositories/credentials_repository.dart';
import 'package:domain/repositories/images_repository.dart';
import 'package:domain/repositories/movies_repository.dart';
import 'package:domain/repositories/remote_store_repository.dart';
import 'package:domain/services/analytics_service.dart';
import 'package:domain/services/app_config_service.dart';
import 'package:domain/usecases/delay_usecase.dart';
import 'package:domain/usecases/facebook_auth_usecase.dart';
import 'package:domain/usecases/get_coming_soon_movies_usecase.dart';
import 'package:domain/usecases/get_image_url_usecase.dart';
import 'package:domain/usecases/get_movie_cast_usecase.dart';
import 'package:domain/usecases/get_now_showing_movies_usecase.dart';
import 'package:domain/usecases/google_auth_usecase.dart';
import 'package:domain/usecases/log_analytics_event_usecase.dart';
import 'package:domain/usecases/save_credentials_usecase.dart';
import 'package:domain/usecases/user_is_registered_usecase.dart';
import 'package:get_it/get_it.dart';

Future<void> initDomainInjector() async {
  _initUsecaseModule();
}

Future<void> _initUsecaseModule() async {
  GetIt.I.registerFactory<DelayUseCase>(
    () => DelayUseCase(),
  );

  GetIt.I.registerFactory<GetNowShowingMoviesUseCase>(
    () => GetNowShowingMoviesUseCase(
      GetIt.I.get<MoviesRepository>(),
    ),
  );
  GetIt.I.registerFactory<GetComingSoonMoviesUseCase>(
    () => GetComingSoonMoviesUseCase(
      GetIt.I.get<MoviesRepository>(),
    ),
  );

  final appConfigService = GetIt.I.get<AppConfigService>();

  final imdbApiKey = await appConfigService.getConfigValue<int>(
    IMDBConfig.imdbApiKeyJsonConfigName,
  );

  GetIt.I.registerFactory<GetMovieCastUseCase>(
    () => GetMovieCastUseCase(
      GetIt.I.get<MoviesRepository>(),
      GetIt.I.get<ImagesRepository>(),
    ),
  );

  GetIt.I.registerFactory<GetImageUrlUseCase>(
    () => GetImageUrlUseCase(
      imdbApiKey.toString(),
    ),
  );

  GetIt.I.registerFactory<UserIsRegisteredUseCase>(
    () => UserIsRegisteredUseCase(GetIt.I.get<RemoteStoreRepository>()),
  );

  GetIt.I.registerFactory<FacebookAuthUseCase>(
    () => FacebookAuthUseCase(GetIt.I.get<AuthRepository>()),
  );

  GetIt.I.registerFactory<GoogleAuthUseCase>(
    () => GoogleAuthUseCase(GetIt.I.get<AuthRepository>()),
  );

  GetIt.I.registerFactory<SaveCredentialsUseCase>(
    () => SaveCredentialsUseCase(GetIt.I.get<CredentialsRepository>()),
  );

  GetIt.I.registerFactory<LogAnalyticsEventUseCase>(
    () => LogAnalyticsEventUseCase(GetIt.I.get<AnalyticsService>()),
  );
}

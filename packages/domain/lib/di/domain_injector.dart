import 'package:domain/const.dart';
import 'package:domain/repositories/images_repository.dart';
import 'package:domain/repositories/movies_repository.dart';
import 'package:domain/services/app_config_service.dart';
import 'package:domain/usecases/delay_usecase.dart';
import 'package:domain/usecases/get_coming_soon_movies_usecase.dart';
import 'package:domain/usecases/get_image_url_usecase.dart';
import 'package:domain/usecases/get_movie_cast_usecase.dart';
import 'package:domain/usecases/get_now_showing_movies_usecase.dart';
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
}

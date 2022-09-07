import 'package:domain/repositories/movies_repository.dart';
import 'package:domain/usecases/delay_usecase.dart';
import 'package:domain/usecases/get_coming_soon_movies_usecase.dart';
import 'package:domain/usecases/get_now_showing_movies_usecase.dart';
import 'package:get_it/get_it.dart';

void initDomainInjector() {
  _initUsecaseModule();
}

void _initUsecaseModule() {
  GetIt.I.registerFactory<DelayUsecase>(() => DelayUsecase());

  GetIt.I.registerFactory<GetNowShowingMoviesUseCase>(
      () => GetNowShowingMoviesUseCase(GetIt.I.get<MoviesRepository>()));
  GetIt.I.registerFactory<GetComingSoonMoviesUseCase>(
      () => GetComingSoonMoviesUseCase(GetIt.I.get<MoviesRepository>()));
}

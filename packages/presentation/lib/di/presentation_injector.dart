import 'package:domain/usecases/delay_usecase.dart';
import 'package:presentation/app/app_bloc.dart';
import 'package:presentation/navigation/app_navigator.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/screens/home/home_bloc.dart';
import 'package:presentation/screens/movie_details/movie_details_bloc.dart';
import 'package:presentation/screens/splash/splash_bloc.dart';

void initPresentationInjector() {
  _initAppModule();
  _initSplashModule();
  _initHomeModule();
  _initMovieDetailsModule();
}

void _initAppModule() {
  GetIt.I.registerFactory<AppBloc>(
    () => AppBloc(),
  );

  GetIt.I.registerSingleton<AppNavigator>(
    AppNavigator(),
  );
}

void _initSplashModule() {
  GetIt.I.registerFactory<SplashBloc>(
    () => SplashBloc(GetIt.I.get<DelayUsecase>()),
  );
}

void _initHomeModule() {
  GetIt.I.registerFactory<HomeBloc>(
    () => HomeBloc(),
  );
}

void _initMovieDetailsModule() {
  GetIt.I.registerFactory<MovieDetailsBloc>(
    () => MovieDetailsBloc(),
  );
}

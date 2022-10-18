import 'package:domain/usecases/delay_usecase.dart';
import 'package:domain/usecases/facebook_auth_usecase.dart';
import 'package:domain/usecases/get_coming_soon_movies_usecase.dart';
import 'package:domain/usecases/get_image_url_usecase.dart';
import 'package:domain/usecases/get_movie_cast_usecase.dart';
import 'package:domain/usecases/get_now_showing_movies_usecase.dart';
import 'package:domain/usecases/google_auth_usecase.dart';
import 'package:domain/usecases/log_analytics_screen_usecase.dart';
import 'package:domain/usecases/login_validation_usecase.dart';
import 'package:domain/usecases/save_credentials_usecase.dart';
import 'package:domain/usecases/share_movie_usecase.dart';
import 'package:domain/usecases/user_is_registered_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/app/app_bloc.dart';
import 'package:presentation/navigation/app_navigator.dart';
import 'package:presentation/screens/home/home_bloc.dart';
import 'package:presentation/screens/login/login_bloc.dart';
import 'package:presentation/screens/login/login_view_mapper.dart';
import 'package:presentation/screens/movie_details/movie_details_bloc.dart';
import 'package:presentation/screens/splash/splash_bloc.dart';

void initPresentationInjector() {
  _initAppModule();
  _initSplashModule();
  _initLoginModule();
  _initHomeModule();
  _initMovieDetailsModule();
}

void _initAppModule() {
  GetIt.I.registerFactory<AppBloc>(
    () => AppBloc(GetIt.I.get<LogAnalyticsScreenUseCase>()),
  );

  GetIt.I.registerSingleton<AppNavigator>(
    AppNavigator(),
  );
}

void _initSplashModule() {
  GetIt.I.registerFactory<SplashBloc>(
    () => SplashBloc(GetIt.I.get<DelayUseCase>()),
  );
}

void _initLoginModule() {
  GetIt.I.registerFactory<LoginViewMapper>(() => LoginViewMapperImpl());

  GetIt.I.registerFactory<LoginBloc>(
    () => LoginBloc(
      GetIt.I.get<UserIsRegisteredUseCase>(),
      GetIt.I.get<FacebookAuthUseCase>(),
      GetIt.I.get<GoogleAuthUseCase>(),
      GetIt.I.get<SaveCredentialsUseCase>(),
      GetIt.I.get<LoginValidationUseCase>(),
      GetIt.I.get<LoginViewMapper>(),
    ),
  );
}

void _initHomeModule() {
  GetIt.I.registerFactory<HomeBloc>(
    () => HomeBloc(
      GetIt.I.get<GetNowShowingMoviesUseCase>(),
      GetIt.I.get<GetComingSoonMoviesUseCase>(),
      GetIt.I.get<GetImageUrlUseCase>(),
    ),
  );
}

void _initMovieDetailsModule() {
  GetIt.I.registerFactory<MovieDetailsBloc>(
    () => MovieDetailsBloc(
      GetIt.I.get<GetImageUrlUseCase>(),
      GetIt.I.get<GetMovieCastUseCase>(),
      GetIt.I.get<ShareMovieUseCase>(),
    ),
  );
}

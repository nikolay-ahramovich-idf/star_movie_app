import 'package:presentation/app/app_bloc.dart';
import 'package:presentation/navigation/app_navigator.dart';
import 'package:get_it/get_it.dart';

void initPresentationInjector() {
  _initAppModule();
}

void _initAppModule() {
  GetIt.I.registerFactory<AppBloc>(
    () => AppBloc(),
  );
  GetIt.I.registerSingleton<AppNavigator>(
    AppNavigator(),
  );
}

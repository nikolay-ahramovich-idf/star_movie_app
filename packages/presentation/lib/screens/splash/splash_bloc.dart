import 'package:domain/usecases/delay_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/bloc/base/bloc.dart';
import 'package:presentation/bloc/base/bloc_impl.dart';
import 'package:presentation/navigation/app_navigator.dart';
import 'package:presentation/screens/main/main_screen.dart';
import 'package:presentation/screens/splash/data/splash_data.dart';

abstract class SplashBloc implements Bloc<SplashData> {
  factory SplashBloc() => _SplashBloc(GetIt.I.get<DelayUsecase>());
}

class _SplashBloc extends BlocImpl<SplashData> implements SplashBloc {
  final AppNavigator _appNavigator = GetIt.I.get<AppNavigator>();
  final DelayUsecase _delayUsecase;

  _SplashBloc(this._delayUsecase) : super(initState: SplashData.init());

  @override
  Future<void> initState() async {
    await _delayUsecase();
    _goToMainPage();
  }

  void _goToMainPage() {
    _appNavigator.popAndPush(MainScreen.page());
  }
}

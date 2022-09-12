import 'package:get_it/get_it.dart';
import 'package:domain/usecases/delay_usecase.dart';
import 'package:presentation/bloc/base/base_state.dart';
import 'package:presentation/bloc/base/bloc.dart';
import 'package:presentation/bloc/base/bloc_impl.dart';
import 'package:presentation/screens/home/home_screen.dart';

abstract class SplashBloc implements Bloc<BaseState> {
  factory SplashBloc() => _SplashBloc(GetIt.I.get<DelayUsecase>());
}

class _SplashBloc extends BlocImpl<BaseState> implements SplashBloc {
  final DelayUsecase _delayUsecase;

  _SplashBloc(this._delayUsecase) : super(initState: const BaseState.init());

  @override
  void initState() {
    initDataAndShowHomePage();
  }

  Future<void> initDataAndShowHomePage() async {
    await _delayUsecase();
    appNavigator.popAndPush(HomeScreen.page());
  }
}

import 'package:domain/usecases/delay_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/bloc/base/base_state.dart';
import 'package:presentation/bloc/base/bloc.dart';
import 'package:presentation/bloc/base/bloc_impl.dart';
import 'package:presentation/navigation/app_navigator.dart';
import 'package:presentation/screens/main/main_screen.dart';

abstract class SplashBloc implements Bloc<BaseState> {
  factory SplashBloc(DelayUsecase delayUsecase) => _SplashBloc(delayUsecase);
}

class _SplashBloc extends BlocImpl<BaseState> implements SplashBloc {
  final DelayUsecase _delayUsecase;

  _SplashBloc(this._delayUsecase) : super(initState: const BaseState.init());

  @override
  Future<void> initState() async {
    await _delayUsecase();
    appNavigator.popAndPush(MainScreen.page());
  }
}

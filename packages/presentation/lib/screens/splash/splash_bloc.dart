import 'package:domain/usecases/delay_usecase.dart';
import 'package:presentation/bloc/base/base_state.dart';
import 'package:presentation/bloc/base/bloc.dart';
import 'package:presentation/bloc/base/bloc_impl.dart';
import 'package:presentation/navigation/base_arguments.dart';
import 'package:presentation/screens/home/home_screen.dart';

abstract class SplashBloc implements Bloc<BaseArguments, BaseState> {
  factory SplashBloc(DelayUseCase delayUsecase) => _SplashBloc(delayUsecase);
}

class _SplashBloc extends BlocImpl<BaseArguments, BaseState>
    implements SplashBloc {
  final DelayUseCase _delayUsecase;

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

import 'package:presentation/bloc/base/base_state.dart';
import 'package:presentation/bloc/base/bloc.dart';
import 'package:presentation/bloc/base/bloc_impl.dart';
import 'package:presentation/navigation/base_arguments.dart';

// TODO change BaseState to real state
abstract class LoginBloc implements Bloc<BaseArguments, BaseState> {
  factory LoginBloc() => _LoginBloc();
}

class _LoginBloc extends BlocImpl<BaseArguments, BaseState>
    implements LoginBloc {
  _LoginBloc() : super(initState: const BaseState.init());
}

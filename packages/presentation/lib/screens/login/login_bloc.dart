import 'package:domain/entities/user_entity.dart';
import 'package:domain/usecases/create_user_usecase.dart';
import 'package:domain/usecases/user_is_registered_usecase.dart';
import 'package:presentation/bloc/base/bloc.dart';
import 'package:presentation/bloc/base/bloc_impl.dart';
import 'package:presentation/navigation/base_arguments.dart';
import 'package:presentation/screens/login/data/login_data.dart';
import 'package:presentation/screens/login/success_login_screen.dart';

abstract class LoginBloc implements Bloc<BaseArguments, LoginData> {
  factory LoginBloc(
    CreateUserUseCase createUserUseCase,
    UserIsRegisteredUseCase userIsRegisteredUseCase,
  ) =>
      _LoginBloc(
        createUserUseCase,
        userIsRegisteredUseCase,
      );

  void updateLogin(String newLogin);
  void updatePassword(String newPassword);
  Future<void> onLogin();
}

class _LoginBloc extends BlocImpl<BaseArguments, LoginData>
    implements LoginBloc {
  final CreateUserUseCase _createUserUseCase;
  final UserIsRegisteredUseCase _userIsRegisteredUseCase;

  _LoginBloc(
    this._createUserUseCase,
    this._userIsRegisteredUseCase,
  ) : super(initState: const LoginData.init());

  @override
  void updateLogin(String newLogin) {
    add(state.copyWith(login: newLogin));
  }

  @override
  void updatePassword(String newPassword) {
    add(state.copyWith(password: newPassword));
  }

  @override
  Future<void> onLogin() async {
    final user = UserEntity(
      login: state.login,
      password: state.password,
    );

    final userIsRegistered = await _userIsRegisteredUseCase(user);

    if (userIsRegistered) {
      appNavigator.popAndPush(SuccessLoginScreen.page());
    }
  }
}

import 'package:domain/entities/user_entity.dart';
import 'package:domain/usecases/create_user_usecase.dart';
import 'package:domain/usecases/facebook_auth_usecase.dart';
import 'package:domain/usecases/google_auth_usecase.dart';
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
    FacebookAuthUseCase facebookAuthUseCase,
    GoogleAuthUseCase googleAuthUseCase,
  ) =>
      _LoginBloc(
        createUserUseCase,
        userIsRegisteredUseCase,
        facebookAuthUseCase,
        googleAuthUseCase,
      );

  void updateLogin(String newLogin);
  void updatePassword(String newPassword);
  Future<void> onLogin();
  Future<void> loginByFacebook();
  Future<void> loginByGoogle();
}

class _LoginBloc extends BlocImpl<BaseArguments, LoginData>
    implements LoginBloc {
  final CreateUserUseCase _createUserUseCase; // TODO remove usecase
  final UserIsRegisteredUseCase _userIsRegisteredUseCase;
  final FacebookAuthUseCase _facebookAuthUseCase;
  final GoogleAuthUseCase _googleAuthUseCase;

  _LoginBloc(
    this._createUserUseCase,
    this._userIsRegisteredUseCase,
    this._facebookAuthUseCase,
    this._googleAuthUseCase,
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

  @override
  Future<void> loginByFacebook() async {
    final user = await _facebookAuthUseCase();

    if (user != null) {
      add(LoginData(
        user.login,
        user.password,
      ));
    }
  }

  @override
  Future<void> loginByGoogle() async {
    final user = await _googleAuthUseCase();

    print('${user?.login} - ${user?.password}');

    if (user != null) {
      add(LoginData(
        user.login,
        user.password,
      ));
    }
  }
}

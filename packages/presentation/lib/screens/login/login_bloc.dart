import 'package:domain/entities/user_entity.dart';
import 'package:domain/usecases/create_user_usecase.dart';
import 'package:domain/usecases/facebook_auth_usecase.dart';
import 'package:domain/usecases/google_auth_usecase.dart';
import 'package:domain/usecases/save_credentials_usecase.dart';
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
    SaveCredentialsUseCase saveCredentialsUseCase,
  ) =>
      _LoginBloc(
        createUserUseCase,
        userIsRegisteredUseCase,
        facebookAuthUseCase,
        googleAuthUseCase,
        saveCredentialsUseCase,
      );

  void updateLogin(String newLogin);
  void updatePassword(String newPassword);
  Future<void> onLogin();
  Future<void> authByFacebook();
  Future<void> authByGoogle();
}

class _LoginBloc extends BlocImpl<BaseArguments, LoginData>
    implements LoginBloc {
  final CreateUserUseCase _createUserUseCase; // TODO remove usecase
  final UserIsRegisteredUseCase _userIsRegisteredUseCase;
  final FacebookAuthUseCase _facebookAuthUseCase;
  final GoogleAuthUseCase _googleAuthUseCase;
  final SaveCredentialsUseCase _saveCredentialsUseCase;

  _LoginBloc(
    this._createUserUseCase,
    this._userIsRegisteredUseCase,
    this._facebookAuthUseCase,
    this._googleAuthUseCase,
    this._saveCredentialsUseCase,
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
      await _saveCredentialsUseCase(user);
      appNavigator.popAndPush(SuccessLoginScreen.page());
    }
  }

  @override
  Future<void> authByFacebook() async {
    final user = await _facebookAuthUseCase();

    if (user != null) {
      add(LoginData(
        user.login,
        user.password,
      ));
    }
  }

  @override
  Future<void> authByGoogle() async {
    final user = await _googleAuthUseCase();

    if (user != null) {
      add(LoginData(
        user.login,
        user.password,
      ));
    }
  }
}

import 'package:domain/entities/user_entity.dart';
import 'package:domain/usecases/facebook_auth_usecase.dart';
import 'package:domain/usecases/google_auth_usecase.dart';
import 'package:domain/usecases/log_social_network_auth_usecase.dart';
import 'package:domain/usecases/save_credentials_usecase.dart';
import 'package:domain/usecases/user_is_registered_usecase.dart';
import 'package:presentation/bloc/base/bloc.dart';
import 'package:presentation/bloc/base/bloc_impl.dart';
import 'package:presentation/navigation/base_arguments.dart';
import 'package:presentation/screens/login/data/login_data.dart';
import 'package:presentation/screens/login/success_login_screen.dart';

abstract class LoginBloc implements Bloc<BaseArguments, LoginData> {
  factory LoginBloc(
    UserIsRegisteredUseCase userIsRegisteredUseCase,
    FacebookAuthUseCase facebookAuthUseCase,
    GoogleAuthUseCase googleAuthUseCase,
    SaveCredentialsUseCase saveCredentialsUseCase,
    LogSocialNetworkAuthUseCase logSocialNetworkAuthUseCase,
  ) =>
      _LoginBloc(
        userIsRegisteredUseCase,
        facebookAuthUseCase,
        googleAuthUseCase,
        saveCredentialsUseCase,
        logSocialNetworkAuthUseCase,
      );

  void updateLogin(String newLogin);

  void updatePassword(String newPassword);

  Future<void> onLogin();

  Future<void> authByFacebook();

  Future<void> authByGoogle();
}

class _LoginBloc extends BlocImpl<BaseArguments, LoginData>
    implements LoginBloc {
  final UserIsRegisteredUseCase _userIsRegisteredUseCase;
  final FacebookAuthUseCase _facebookAuthUseCase;
  final GoogleAuthUseCase _googleAuthUseCase;
  final SaveCredentialsUseCase _saveCredentialsUseCase;
  final LogSocialNetworkAuthUseCase _logSocialNetworkAuthUseCase;

  _LoginBloc(
    this._userIsRegisteredUseCase,
    this._facebookAuthUseCase,
    this._googleAuthUseCase,
    this._saveCredentialsUseCase,
    this._logSocialNetworkAuthUseCase,
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
    await _logSocialNetworkAuthUseCase('auth_by_login');

    final user = UserEntity(
      login: state.login,
      password: state.password,
    );

    await _loginIfUserRegistered(user);
  }

  @override
  Future<void> authByFacebook() async {
    await _logSocialNetworkAuthUseCase('auth_by_facebook');
    final user = await _facebookAuthUseCase();

    if (user != null) {
      add(LoginData(
        user.login,
        user.password,
      ));

      await _loginIfUserRegistered(user);
    }
  }

  @override
  Future<void> authByGoogle() async {
    await _logSocialNetworkAuthUseCase('auth_by_google');
    final user = await _googleAuthUseCase();

    if (user != null) {
      add(LoginData(
        user.login,
        user.password,
      ));

      await _loginIfUserRegistered(user);
    }
  }

  Future<void> _loginIfUserRegistered(UserEntity user) async {
    final userIsRegistered = await _userIsRegisteredUseCase(user);

    if (userIsRegistered) {
      await _saveCredentialsUseCase(user);
      appNavigator.popAndPush(SuccessLoginScreen.page());
    }
  }
}

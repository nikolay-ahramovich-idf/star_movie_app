import 'package:domain/entities/event_entity.dart';
import 'package:domain/entities/user_entity.dart';
import 'package:domain/exceptions/auth_failure_exception.dart';
import 'package:domain/usecases/facebook_auth_usecase.dart';
import 'package:domain/usecases/google_auth_usecase.dart';
import 'package:domain/usecases/save_credentials_usecase.dart';
import 'package:domain/usecases/user_is_registered_usecase.dart';
import 'package:flutter/material.dart';
import 'package:presentation/bloc/base/bloc.dart';
import 'package:presentation/bloc/base/bloc_impl.dart';
import 'package:presentation/const.dart';
import 'package:presentation/navigation/base_arguments.dart';
import 'package:presentation/screens/login/data/login_data.dart';
import 'package:presentation/screens/login/success_login_screen.dart';

abstract class LoginBloc implements Bloc<BaseArguments, LoginData> {
  factory LoginBloc(
    UserIsRegisteredUseCase userIsRegisteredUseCase,
    FacebookAuthUseCase facebookAuthUseCase,
    GoogleAuthUseCase googleAuthUseCase,
    SaveCredentialsUseCase saveCredentialsUseCase,
  ) =>
      _LoginBloc(
        userIsRegisteredUseCase,
        facebookAuthUseCase,
        googleAuthUseCase,
        saveCredentialsUseCase,
      );

  TextEditingController get loginController;

  TextEditingController get passwordController;

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

  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _LoginBloc(
    this._userIsRegisteredUseCase,
    this._facebookAuthUseCase,
    this._googleAuthUseCase,
    this._saveCredentialsUseCase,
  ) : super(initState: const LoginData.init());

  @override
  TextEditingController get loginController => _loginController;

  @override
  TextEditingController get passwordController => _passwordController;

  @override
  Future<void> onLogin() async {
    final event = EventEntity(
      AnalyticsEvents.loginScreenEvents.buttonAuthByLoginClick,
    );

    logAnalyticsEventUseCase(event);

    final user = UserEntity(
      login: _loginController.text,
      password: _passwordController.text,
    );

    try {
      await _loginIfUserRegistered(user);
    } on AuthFailureException {
      add(LoginData(true));
    }
  }

  @override
  Future<void> authByFacebook() async {
    final event = EventEntity(
      AnalyticsEvents.loginScreenEvents.buttonAuthByFacebookClick,
    );

    logAnalyticsEventUseCase(event);

    try {
      final user = await _facebookAuthUseCase();

      _updateFieldControllers(user);

      add(LoginData(false));

      await _loginIfUserRegistered(user);
    } on AuthFailureException {
      add(
        LoginData(true),
      );
    }
  }

  @override
  Future<void> authByGoogle() async {
    final event = EventEntity(
      AnalyticsEvents.loginScreenEvents.buttonAuthByGoogleClick,
    );

    logAnalyticsEventUseCase(event);

    try {
      final user = await _googleAuthUseCase();

      _updateFieldControllers(user);

      add(LoginData(
        false,
      ));

      await _loginIfUserRegistered(user);
    } on AuthFailureException {
      add(
        LoginData(
          true,
        ),
      );
    }
  }

  void _updateFieldControllers(UserEntity user) {
    _loginController.text = user.login;
    _passwordController.text = user.password;
  }

  Future<void> _loginIfUserRegistered(UserEntity user) async {
    final userIsRegistered = await _userIsRegisteredUseCase(user);

    if (userIsRegistered) {
      await _saveCredentialsUseCase(user);
      appNavigator.popAndPush(SuccessLoginScreen.page());
    } else {
      throw AuthFailureException();
    }
  }
}

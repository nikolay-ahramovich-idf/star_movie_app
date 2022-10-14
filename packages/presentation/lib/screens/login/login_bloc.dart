import 'package:domain/entities/event_entity.dart';
import 'package:domain/entities/user_entity.dart';
import 'package:domain/exceptions/auth_failure_exception.dart';
import 'package:domain/usecases/facebook_auth_usecase.dart';
import 'package:domain/usecases/google_auth_usecase.dart';
import 'package:domain/usecases/login_validation_usecase.dart';
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
    LoginValidationUseCase loginValidationUseCase,
  ) =>
      _LoginBloc(
        userIsRegisteredUseCase,
        facebookAuthUseCase,
        googleAuthUseCase,
        saveCredentialsUseCase,
        loginValidationUseCase,
      );

  TextEditingController get loginController;

  TextEditingController get passwordController;

  Future<void> onLogin();

  Future<void> authByFacebook();

  Future<void> authByGoogle();

  bool validateForm();

  String? loginValidator(String warningMessage);

  String? passwordValidator(String warningMessage);
}

class _LoginBloc extends BlocImpl<BaseArguments, LoginData>
    implements LoginBloc {
  final UserIsRegisteredUseCase _userIsRegisteredUseCase;
  final FacebookAuthUseCase _facebookAuthUseCase;
  final GoogleAuthUseCase _googleAuthUseCase;
  final SaveCredentialsUseCase _saveCredentialsUseCase;
  final LoginValidationUseCase _loginValidationUseCase;

  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _LoginBloc(
    this._userIsRegisteredUseCase,
    this._facebookAuthUseCase,
    this._googleAuthUseCase,
    this._saveCredentialsUseCase,
    this._loginValidationUseCase,
  ) : super(initState: const LoginData.init());

  @override
  TextEditingController get loginController => _loginController;

  @override
  TextEditingController get passwordController => _passwordController;

  @override
  Future<void> onLogin() async {
    logAnalyticsEventUseCase(
      AnalyticsEvents.loginScreenEvents.buttonAuthByLoginClick,
    );

    final user = UserEntity(
      login: _loginController.text,
      password: _passwordController.text,
    );

    try {
      await _loginIfUserRegistered(user);
    } on AuthFailureException {
      add(state.copyWith(authFailure: true));
    }
  }

  @override
  Future<void> authByFacebook() async {
    logAnalyticsEventUseCase(
      AnalyticsEvents.loginScreenEvents.buttonAuthByFacebookClick,
    );

    try {
      final user = await _facebookAuthUseCase();

      _updateFieldControllers(user);

      add(state.copyWith(authFailure: false));

      await _loginIfUserRegistered(user);
    } on AuthFailureException {
      add(
        state.copyWith(authFailure: true),
      );
    }
  }

  @override
  Future<void> authByGoogle() async {
    logAnalyticsEventUseCase(
      AnalyticsEvents.loginScreenEvents.buttonAuthByGoogleClick,
    );

    try {
      final user = await _googleAuthUseCase();

      _updateFieldControllers(user);

      add(state.copyWith(
        authFailure: false,
      ));

      await _loginIfUserRegistered(user);
    } on AuthFailureException {
      add(
        state.copyWith(
          authFailure: true,
        ),
      );
    }
  }

  @override
  bool validateForm() {
    final user = UserEntity(
      login: _loginController.text,
      password: _passwordController.text,
    );

    final validationResult = _loginValidationUseCase(user);

    add(
      state.copyWith(
        loginIsCorrect: validationResult.loginIsCorrect,
        passwordIsCorrect: validationResult.passwordIsCorrect,
      ),
    );

    return validationResult.loginIsCorrect &&
        validationResult.passwordIsCorrect;
  }

  @override
  String? loginValidator(String warningMessage) =>
      state.loginIsCorrect ? null : warningMessage;

  @override
  String? passwordValidator(String warningMessage) =>
      state.passwordIsCorrect ? null : warningMessage;

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

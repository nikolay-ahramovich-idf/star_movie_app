import 'package:domain/entities/user_entity.dart';
import 'package:domain/exceptions/auth_failure_exception.dart';
import 'package:domain/exceptions/validation_exception.dart';
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
import 'package:presentation/screens/login/login_view_mapper.dart';
import 'package:presentation/screens/login/success_login_screen.dart';

abstract class LoginBloc implements Bloc<BaseArguments, LoginData> {
  factory LoginBloc(
    UserIsRegisteredUseCase userIsRegisteredUseCase,
    FacebookAuthUseCase facebookAuthUseCase,
    GoogleAuthUseCase googleAuthUseCase,
    SaveCredentialsUseCase saveCredentialsUseCase,
    LoginValidationUseCase loginValidationUseCase,
    LoginViewMapper loginViewMapper,
  ) =>
      _LoginBloc(
        userIsRegisteredUseCase,
        facebookAuthUseCase,
        googleAuthUseCase,
        saveCredentialsUseCase,
        loginValidationUseCase,
        loginViewMapper,
      );

  GlobalKey<FormState> get formStateGlobalKey;

  TextEditingController get loginController;

  TextEditingController get passwordController;

  LoginViewMapper get loginViewMapper;

  Future<void> onLogin();

  Future<void> authByFacebook();

  Future<void> authByGoogle();

  void validateForm();
}

class _LoginBloc extends BlocImpl<BaseArguments, LoginData>
    implements LoginBloc {
  final UserIsRegisteredUseCase _userIsRegisteredUseCase;
  final FacebookAuthUseCase _facebookAuthUseCase;
  final GoogleAuthUseCase _googleAuthUseCase;
  final SaveCredentialsUseCase _saveCredentialsUseCase;
  final LoginValidationUseCase _loginValidationUseCase;
  final LoginViewMapper _loginViewMapper;

  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formStateGlobalKey = GlobalKey<FormState>();

  _LoginBloc(
    this._userIsRegisteredUseCase,
    this._facebookAuthUseCase,
    this._googleAuthUseCase,
    this._saveCredentialsUseCase,
    this._loginValidationUseCase,
    this._loginViewMapper,
  ) : super(initState: const LoginData.init());

  @override
  void initState() {
    super.initState();

    _loginController.addListener(_resetErrorMessages);

    _passwordController.addListener(_resetErrorMessages);
  }

  @override
  GlobalKey<FormState> get formStateGlobalKey => _formStateGlobalKey;

  @override
  TextEditingController get loginController => _loginController;

  @override
  TextEditingController get passwordController => _passwordController;

  @override
  LoginViewMapper get loginViewMapper => _loginViewMapper;

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
    } on AuthFailureException catch (e) {
      print(e);
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

      await _loginIfUserRegistered(user);
    } on AuthFailureException catch (e) {
      print(e);
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

      await _loginIfUserRegistered(user);
    } on AuthFailureException catch (e) {
      print(e);
    }
  }

  @override
  void validateForm() {
    final user = UserEntity(
      login: _loginController.text,
      password: _passwordController.text,
    );

    final validationResult = _loginValidationUseCase(user);

    add(
      state.copyWith(
        loginValidationStatus: validationResult.loginValidationStatus,
        passwordValidationStatus: validationResult.passwordValidationStatus,
      ),
    );

    if (_formStateGlobalKey.currentState!.validate()) {
      onLogin();
    }
  }

  @override
  void dispose() {
    _loginController.dispose();

    _passwordController.dispose();

    super.dispose();
  }

  void _resetErrorMessages() {
    add(
      state.copyWith(
        authFailure: false,
        loginValidationStatus: ValidationExceptionStatus.ok,
        passwordValidationStatus: ValidationExceptionStatus.ok,
      ),
    );

    _formStateGlobalKey.currentState?.validate();
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
      add(state.copyWith(authFailure: true));
      _formStateGlobalKey.currentState?.validate();
    }
  }
}

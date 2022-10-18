import 'package:domain/entities/validation_entity.dart';

class LoginData {
  final bool authFailure;
  final LoginValidationStatus loginValidationStatus;
  final PasswordValidationStatus passwordValidationStatus;

  LoginData(
    this.authFailure,
    this.loginValidationStatus,
    this.passwordValidationStatus,
  );

  const LoginData.init()
      : authFailure = false,
        loginValidationStatus = LoginValidationStatus.ok,
        passwordValidationStatus = PasswordValidationStatus.ok;

  LoginData copyWith({
    bool? authFailure,
    LoginValidationStatus? loginValidationStatus,
    PasswordValidationStatus? passwordValidationStatus,
  }) {
    return LoginData(
      authFailure ?? this.authFailure,
      loginValidationStatus ?? this.loginValidationStatus,
      passwordValidationStatus ?? this.passwordValidationStatus,
    );
  }
}

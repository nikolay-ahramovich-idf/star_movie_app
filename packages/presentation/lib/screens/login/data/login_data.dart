import 'package:domain/exceptions/validation_exception.dart';

class LoginData {
  final bool authFailure;
  final ValidationExceptionStatus loginValidationStatus;
  final ValidationExceptionStatus passwordValidationStatus;

  LoginData(
    this.authFailure,
    this.loginValidationStatus,
    this.passwordValidationStatus,
  );

  const LoginData.init()
      : authFailure = false,
        loginValidationStatus = ValidationExceptionStatus.ok,
        passwordValidationStatus = ValidationExceptionStatus.ok;

  LoginData copyWith({
    bool? authFailure,
    ValidationExceptionStatus? loginValidationStatus,
    ValidationExceptionStatus? passwordValidationStatus,
  }) {
    return LoginData(
      authFailure ?? this.authFailure,
      loginValidationStatus ?? this.loginValidationStatus,
      passwordValidationStatus ?? this.passwordValidationStatus,
    );
  }
}

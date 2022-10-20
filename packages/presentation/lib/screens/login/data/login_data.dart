import 'package:domain/exceptions/validation_exception.dart';

class LoginData {
  final ValidationExceptionStatus? loginValidationStatus;
  final ValidationExceptionStatus? passwordValidationStatus;

  LoginData(
    this.loginValidationStatus,
    this.passwordValidationStatus,
  );

  const LoginData.init()
      : loginValidationStatus = null,
        passwordValidationStatus = null;

  LoginData copyWith({
    ValidationExceptionStatus? loginValidationStatus,
    ValidationExceptionStatus? passwordValidationStatus,
  }) {
    return LoginData(
      loginValidationStatus ?? this.loginValidationStatus,
      passwordValidationStatus ?? this.passwordValidationStatus,
    );
  }
}

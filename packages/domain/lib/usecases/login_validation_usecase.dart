import 'package:domain/entities/user_entity.dart';
import 'package:domain/exceptions/validation_exception.dart';
import 'package:domain/usecases/usecase.dart';

class LoginValidationUseCase implements UseCaseParams<UserEntity, void> {
  final loginLength = 8;
  final passwordRegExp = r'^[a-zA-Z0-9]{7,}$';

  @override
  void call(UserEntity params) {
    final loginValidationStatus = _validateLogin(params.login);
    final passwordValidationStatus = _validatePassword(params.password);

    if (loginValidationStatus != null || passwordValidationStatus != null) {
      throw ValidationException(
        loginValidationStatus,
        passwordValidationStatus,
      );
    }
  }

  ValidationExceptionStatus? _validateLogin(String login) {
    if (login.isEmpty) {
      return ValidationExceptionStatus.empty;
    }

    if (login.length < loginLength) {
      return ValidationExceptionStatus.minLength;
    }

    return null;
  }

  ValidationExceptionStatus? _validatePassword(String password) {
    if (password.isEmpty) {
      return ValidationExceptionStatus.empty;
    }

    final regExp = RegExp(passwordRegExp);

    if (!regExp.hasMatch(password)) {
      return ValidationExceptionStatus.regExp;
    }

    return null;
  }
}

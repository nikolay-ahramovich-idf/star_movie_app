import 'package:domain/entities/user_entity.dart';
import 'package:domain/entities/validation_entity.dart';
import 'package:domain/usecases/usecase.dart';

class LoginValidationUseCase
    implements UseCaseParams<UserEntity, ValidationEntity> {
  final loginLength = 8;
  final passwordRegExp = r'^[a-zA-Z0-9]{7,}$';

  @override
  ValidationEntity call(UserEntity params) {
    final loginValidationStatus = _validateLogin(params.login);

    final passwordValidationStatus = _validatePassword(params.password);

    return ValidationEntity(
      loginValidationStatus,
      passwordValidationStatus,
    );
  }

  LoginValidationStatus _validateLogin(String login) {
    if (login.isEmpty) {
      return LoginValidationStatus.empty;
    }

    if (login.length < loginLength) {
      return LoginValidationStatus.notCorrect;
    }

    return LoginValidationStatus.ok;
  }

  PasswordValidationStatus _validatePassword(String password) {
    if (password.isEmpty) {
      return PasswordValidationStatus.empty;
    }

    final regExp = RegExp(passwordRegExp);

    if (!regExp.hasMatch(password)) {
      return PasswordValidationStatus.notCorrect;
    }

    return PasswordValidationStatus.ok;
  }
}

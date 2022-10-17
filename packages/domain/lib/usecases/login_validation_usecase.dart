import 'package:domain/entities/user_entity.dart';
import 'package:domain/entities/validation_entity.dart';
import 'package:domain/usecases/usecase.dart';

class LoginValidationUseCase
    implements UseCaseParams<UserEntity, ValidationEntity> {
  final loginLength = 8;
  final passwordRegExp = r'^[a-zA-Z0-9]{7,}$';

  @override
  ValidationEntity call(UserEntity params) {
    final loginIsEmpty = params.login.isEmpty;
    final passwordIsEmpty = params.password.isEmpty;

    if (loginIsEmpty && passwordIsEmpty) {
      return ValidationEntity(
        loginIsEmpty,
        false,
        passwordIsEmpty,
        false,
      );
    }

    final loginIsValid = _validateLogin(params.login);
    final passwordIsValid = _validatePassword(params.password);

    return ValidationEntity(
      loginIsEmpty,
      loginIsValid,
      passwordIsEmpty,
      passwordIsValid,
    );
  }

  bool _validateLogin(String login) {
    return login.length >= loginLength;
  }

  bool _validatePassword(String password) {
    final regExp = RegExp(passwordRegExp);
    return regExp.hasMatch(password);
  }
}

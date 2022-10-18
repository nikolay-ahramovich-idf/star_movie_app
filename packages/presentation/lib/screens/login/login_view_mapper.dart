import 'package:domain/entities/validation_entity.dart';
import 'package:presentation/screens/login/data/login_data.dart';

abstract class LoginViewMapper {
  factory LoginViewMapper() => LoginViewMapperImpl();

  String? stateToLoginErrorMessage(
    LoginData state, {
    required String authFailureLoginMessage,
    required String requiredLoginMessage,
    required String invalidLoginMessage,
  });

  String? stateToPasswordErrorMessage(
    LoginData state, {
    required String authFailurePasswordMessage,
    required String requiredPasswordMessage,
    required String invalidPasswordMessage,
  });
}

class LoginViewMapperImpl implements LoginViewMapper {
  @override
  String? stateToLoginErrorMessage(
    LoginData state, {
    required String authFailureLoginMessage,
    required String requiredLoginMessage,
    required String invalidLoginMessage,
  }) {
    if (state.authFailure) {
      return authFailureLoginMessage;
    }

    switch (state.loginValidationStatus) {
      case LoginValidationStatus.empty:
        return requiredLoginMessage;
      case LoginValidationStatus.notCorrect:
        return invalidLoginMessage;
      case LoginValidationStatus.ok:
        return null;
    }
  }

  @override
  String? stateToPasswordErrorMessage(
    LoginData state, {
    required String authFailurePasswordMessage,
    required String requiredPasswordMessage,
    required String invalidPasswordMessage,
  }) {
    if (state.authFailure) {
      return authFailurePasswordMessage;
    }

    switch (state.passwordValidationStatus) {
      case PasswordValidationStatus.empty:
        return requiredPasswordMessage;
      case PasswordValidationStatus.notCorrect:
        return invalidPasswordMessage;
      case PasswordValidationStatus.ok:
        return null;
    }
  }
}

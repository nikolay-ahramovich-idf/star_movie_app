import 'package:domain/exceptions/validation_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:presentation/screens/login/data/login_data.dart';

abstract class LoginViewMapper {
  factory LoginViewMapper() => LoginViewMapperImpl();

  String? stateToLoginErrorMessage(
    LoginData state,
    BuildContext context,
  );

  String? stateToPasswordErrorMessage(
    LoginData state,
    BuildContext context,
  );
}

class LoginViewMapperImpl implements LoginViewMapper {
  @override
  String? stateToLoginErrorMessage(
    LoginData state,
    BuildContext context,
  ) {
    final appLocalizations = AppLocalizations.of(context)!;

    if (state.authFailure) {
      return appLocalizations.authFailureLoginMessage;
    }

    switch (state.loginValidationStatus) {
      case ValidationExceptionStatus.empty:
        return appLocalizations.requiredLoginMessage;
      case ValidationExceptionStatus.notCorrect:
        return appLocalizations.invalidLoginMessage;
      case null:
        return null;
    }
  }

  @override
  String? stateToPasswordErrorMessage(
    LoginData state,
    BuildContext context,
  ) {
    final appLocalizations = AppLocalizations.of(context)!;

    if (state.authFailure) {
      return appLocalizations.authFailurePasswordMessage;
    }

    switch (state.passwordValidationStatus) {
      case ValidationExceptionStatus.empty:
        return appLocalizations.requiredPasswordMessage;
      case ValidationExceptionStatus.notCorrect:
        return appLocalizations.requiredPasswordMessage;
      case null:
        return null;
    }
  }
}

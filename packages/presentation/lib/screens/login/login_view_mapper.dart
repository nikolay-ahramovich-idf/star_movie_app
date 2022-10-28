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

    switch (state.loginValidationStatus) {
      case ValidationExceptionStatus.empty:
        return appLocalizations.requiredLoginMessage;
      case ValidationExceptionStatus.minLength:
        return appLocalizations.invalidLoginMessage;
      case ValidationExceptionStatus.authFailed:
        return appLocalizations.authFailureLoginMessage;
      case null:
        return null;
    }
    return null;
  }

  @override
  String? stateToPasswordErrorMessage(
    LoginData state,
    BuildContext context,
  ) {
    final appLocalizations = AppLocalizations.of(context)!;

    switch (state.passwordValidationStatus) {
      case ValidationExceptionStatus.empty:
        return appLocalizations.requiredPasswordMessage;
      case ValidationExceptionStatus.regExp:
        return appLocalizations.requiredPasswordMessage;
      case ValidationExceptionStatus.authFailed:
        return appLocalizations.authFailurePasswordMessage;
      case null:
        return null;
    }
    return null;
  }
}

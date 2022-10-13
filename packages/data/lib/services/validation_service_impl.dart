import 'package:domain/services/validation_service.dart';

class ValidationServiceImpl implements ValidationService {
  final int loginLength;
  final String passwordRegularExpression;

  ValidationServiceImpl(
    this.loginLength,
    this.passwordRegularExpression,
  );

  @override
  bool validateLogin(String login) {
    return login.length >= loginLength;
  }

  @override
  bool validatePassword(String password) {
    final regExp = RegExp(passwordRegularExpression);
    return regExp.hasMatch(password);
  }
}

enum LoginValidationStatus {
  ok,
  empty,
  notCorrect,
}

enum PasswordValidationStatus {
  ok,
  empty,
  notCorrect,
}

class ValidationEntity {
  final LoginValidationStatus loginValidationStatus;
  final PasswordValidationStatus passwordValidationStatus;

  ValidationEntity(
    this.loginValidationStatus,
    this.passwordValidationStatus,
  );
}

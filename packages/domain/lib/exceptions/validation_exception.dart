enum ValidationExceptionStatus {
  empty,
  notCorrect,
  authFailed,
}

class ValidationException {
  final ValidationExceptionStatus? loginValidationStatus;
  final ValidationExceptionStatus? passwordValidationStatus;

  ValidationException(
    this.loginValidationStatus,
    this.passwordValidationStatus,
  );
}

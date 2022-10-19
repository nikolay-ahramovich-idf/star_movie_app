enum ValidationExceptionStatus {
  empty,
  notCorrect,
}

class ValidationException {
  final ValidationExceptionStatus? loginValidationStatus;
  final ValidationExceptionStatus? passwordValidationStatus;

  ValidationException(
    this.loginValidationStatus,
    this.passwordValidationStatus,
  );
}

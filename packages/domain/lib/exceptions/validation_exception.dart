enum ValidationExceptionStatus {
  empty,
  minLength,
  regExp,
  authFailed,
}

class ValidationException implements Exception {
  final ValidationExceptionStatus? loginValidationStatus;
  final ValidationExceptionStatus? passwordValidationStatus;

  ValidationException(
    this.loginValidationStatus,
    this.passwordValidationStatus,
  );
}

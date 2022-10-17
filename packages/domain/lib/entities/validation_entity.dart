class ValidationEntity {
  final bool loginIsEmpty;
  final bool loginIsCorrect;
  final bool passwordIsEmpty;
  final bool passwordIsCorrect;

  ValidationEntity(
    this.loginIsEmpty,
    this.loginIsCorrect,
    this.passwordIsEmpty,
    this.passwordIsCorrect,
  );
}

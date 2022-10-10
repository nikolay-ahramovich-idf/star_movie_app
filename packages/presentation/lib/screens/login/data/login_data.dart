class LoginData {
  final bool authFailure;

  LoginData(
    this.authFailure,
  );

  const LoginData.init() : authFailure = false;
}

class LoginData {
  final bool authFailure;
  final bool loginIsCorrect;
  final bool passwordIsCorrect;

  LoginData(
    this.authFailure,
    this.loginIsCorrect,
    this.passwordIsCorrect,
  );

  const LoginData.init()
      : authFailure = false,
        loginIsCorrect = false,
        passwordIsCorrect = false;

  LoginData copyWith({
    bool? authFailure,
    bool? loginIsCorrect,
    bool? passwordIsCorrect,
  }) {
    return LoginData(
      authFailure ?? this.authFailure,
      loginIsCorrect ?? this.loginIsCorrect,
      passwordIsCorrect ?? this.passwordIsCorrect,
    );
  }
}

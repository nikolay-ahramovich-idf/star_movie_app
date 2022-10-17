class LoginData {
  final bool authFailure;
  final bool loginIsEmpty;
  final bool loginIsCorrect;
  final bool passwordIsEmpty;
  final bool passwordIsCorrect;

  LoginData(
    this.authFailure,
    this.loginIsEmpty,
    this.loginIsCorrect,
    this.passwordIsEmpty,
    this.passwordIsCorrect,
  );

  const LoginData.init()
      : authFailure = false,
        loginIsEmpty = true,
        loginIsCorrect = false,
        passwordIsEmpty = true,
        passwordIsCorrect = false;

  LoginData copyWith({
    bool? authFailure,
    bool? loginIsEmpty,
    bool? loginIsCorrect,
    bool? passwordIsEmpty,
    bool? passwordIsCorrect,
  }) {
    return LoginData(
      authFailure ?? this.authFailure,
      loginIsEmpty ?? this.loginIsEmpty,
      loginIsCorrect ?? this.loginIsCorrect,
      passwordIsEmpty ?? this.passwordIsEmpty,
      passwordIsCorrect ?? this.passwordIsCorrect,
    );
  }
}

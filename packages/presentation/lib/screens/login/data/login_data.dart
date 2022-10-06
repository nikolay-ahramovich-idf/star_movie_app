class LoginData {
  final String login;
  final String password;
  final bool authFailure;

  LoginData(
    this.login,
    this.password,
    this.authFailure,
  );

  const LoginData.init()
      : login = '',
        password = '',
        authFailure = false;

  LoginData copyWith({
    String? login,
    String? password,
    bool? authFailure,
  }) {
    return LoginData(
      login ?? this.login,
      password ?? this.password,
      authFailure ?? this.authFailure,
    );
  }
}

class LoginData {
  final String _login;
  final String _password;

  LoginData(
    this._login,
    this._password,
  );

  String get login => _login;
  String get password => _password;

  const LoginData.init()
      : _login = '',
        _password = '';

  LoginData copyWith({
    String? login,
    String? password,
  }) {
    return LoginData(
      login ?? _login,
      password ?? _password,
    );
  }
}

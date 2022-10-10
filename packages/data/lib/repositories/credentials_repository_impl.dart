import 'package:domain/repositories/credentials_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CredentialsRepositoryImpl implements CredentialsRepository {
  final SharedPreferences _preferencesProvider;

  CredentialsRepositoryImpl(this._preferencesProvider);

  @override
  Future<void> saveCredentials(
    String login,
    String password,
  ) async {
    await _preferencesProvider.setString(
      'login',
      login,
    );
    await _preferencesProvider.setString(
      'password',
      password,
    );
  }
}

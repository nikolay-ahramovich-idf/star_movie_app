import 'package:domain/repositories/credentials_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CredentialsRepositoryImpl implements CredentialsRepository {
  @override
  Future<void> saveCredentials(String login, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('login', login);
    await prefs.setString('password', password);
  }
}

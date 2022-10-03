import 'package:domain/services/auth_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService implements AuthService {
  final _authProvider = GoogleSignIn();

  @override
  Future<Map<String, dynamic>?> login() async {
    final loginResult = await _authProvider.signIn();

    if (loginResult != null) {
      final userData = {
        'email': loginResult.email,
        'id': loginResult.id,
      };

      return userData;
    }

    return null;
  }
}

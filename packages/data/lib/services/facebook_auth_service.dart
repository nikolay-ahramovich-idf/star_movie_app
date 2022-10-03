import 'package:domain/services/auth_service.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookAuthService implements AuthService {
  final _authProvider = FacebookAuth.instance;

  @override
  Future<Map<String, dynamic>?> login() async {
    final loginResult = await FacebookAuth.instance.login();

    if (loginResult.status == LoginStatus.success) {
      return await _authProvider.getUserData();
    }

    return null;
  }
}

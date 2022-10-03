import 'package:domain/entities/user_entity.dart';
import 'package:domain/repositories/auth_repository.dart';
import 'package:domain/services/auth_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _facebookAuthService;
  final AuthService _googleAuthService;

  AuthRepositoryImpl(
    this._facebookAuthService,
    this._googleAuthService,
  );

  @override
  Future<UserEntity?> authWithFacebook() async {
    final userData = await _facebookAuthService.login();

    if (userData != null) {
      return userDataToUserEntity(userData);
    }

    return null;
  }

  @override
  Future<UserEntity?> authWithGoogle() async {
    final userData = await _googleAuthService.login();
    userData?.forEach((key, value) {
      print('$key - $value');
    });

    if (userData != null) {
      return userDataToUserEntity(userData);
    }

    return null;
  }

  UserEntity userDataToUserEntity(Map<String, dynamic> userData) {
    final email = userData['email'];
    final id = userData['id'];

    return UserEntity(
      login: email,
      password: id,
    );
  }
}

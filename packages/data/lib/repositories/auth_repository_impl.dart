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
  Future<UserEntity> authWithFacebook() async {
    final userData = await _facebookAuthService.login();

    return UserEntity.fromAuthJson(userData);
  }

  @override
  Future<UserEntity> authWithGoogle() async {
    final userData = await _googleAuthService.login();

    return UserEntity.fromAuthJson(userData);
  }
}

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
      final login = userData['email'];
      final password = userData['id'];

      return UserEntity(login: login, password: password);
    }

    return null;
  }

  @override
  Future<UserEntity?> authWithGoogle() async {
    // TODO: implement authWithGoogle
    throw UnimplementedError();
  }
}

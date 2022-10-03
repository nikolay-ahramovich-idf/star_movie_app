import 'package:domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> authWithFacebook();
  Future<UserEntity?> authWithGoogle();
}

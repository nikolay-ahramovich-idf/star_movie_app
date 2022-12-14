import 'package:domain/entities/user_entity.dart';
import 'package:domain/repositories/auth_repository.dart';
import 'package:domain/usecases/usecase.dart';

class FacebookAuthUseCase implements UseCase<Future<UserEntity?>> {
  final AuthRepository _authService;

  FacebookAuthUseCase(this._authService);

  @override
  Future<UserEntity> call() => _authService.authWithFacebook();
}

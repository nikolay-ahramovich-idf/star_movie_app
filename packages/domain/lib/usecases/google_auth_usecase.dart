import 'package:domain/entities/user_entity.dart';
import 'package:domain/repositories/auth_repository.dart';
import 'package:domain/usecases/usecase.dart';

class GoogleAuthUseCase implements UseCase<Future<UserEntity?>> {
  final AuthRepository _authService;

  GoogleAuthUseCase(this._authService);

  @override
  Future<UserEntity> call() => _authService.authWithGoogle();
}

import 'package:domain/entities/user_entity.dart';
import 'package:domain/repositories/credentials_repository.dart';
import 'package:domain/usecases/usecase.dart';

class SaveCredentialsUseCase
    implements UseCaseParams<UserEntity, Future<void>> {
  final CredentialsRepository _credentialsRepository;

  SaveCredentialsUseCase(this._credentialsRepository);

  @override
  Future<void> call(UserEntity params) =>
      _credentialsRepository.saveCredentials(
        params.login,
        params.password,
      );
}

import 'package:domain/entities/user_entity.dart';
import 'package:domain/exceptions/validation_exception.dart';
import 'package:domain/repositories/remote_store_repository.dart';
import 'package:domain/usecases/usecase.dart';

class UserIsRegisteredUseCase
    implements UseCaseParams<UserEntity, Future<void>> {
  final RemoteStoreRepository _storeRepository;

  UserIsRegisteredUseCase(this._storeRepository);

  @override
  Future<void> call(UserEntity user) async {
    final userExists = await _storeRepository.checkUserExists(user);

    if (!userExists) {
      throw ValidationException(
        ValidationExceptionStatus.authFailed,
        ValidationExceptionStatus.authFailed,
      );
    }
  }
}

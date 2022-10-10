import 'package:domain/entities/user_entity.dart';
import 'package:domain/repositories/remote_store_repository.dart';
import 'package:domain/usecases/usecase.dart';

class UserIsRegisteredUseCase
    implements UseCaseParams<UserEntity, Future<bool>> {
  final RemoteStoreRepository _storeRepository;

  UserIsRegisteredUseCase(this._storeRepository);

  @override
  Future<bool> call(UserEntity user) => _storeRepository.checkUserExists(user);
}

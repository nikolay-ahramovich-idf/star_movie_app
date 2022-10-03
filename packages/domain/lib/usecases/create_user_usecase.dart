import 'package:domain/entities/user_entity.dart';
import 'package:domain/repositories/remote_store_repository.dart';
import 'package:domain/usecases/usecase.dart';

// TODO remover CreateUserUseCase
class CreateUserUseCase implements UseCaseParams<UserEntity, Future<void>> {
  final RemoteStoreRepository _storeRepository;

  CreateUserUseCase(this._storeRepository);

  @override
  Future<void> call(UserEntity params) async {
    await _storeRepository.createDocument(
      "users", // TODO move users to const
      params.toJson(),
    );
  }
}

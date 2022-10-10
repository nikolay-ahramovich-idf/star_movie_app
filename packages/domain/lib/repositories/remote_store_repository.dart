import 'package:domain/entities/user_entity.dart';

abstract class RemoteStoreRepository {
  Future<bool> checkUserExists(UserEntity user);
}

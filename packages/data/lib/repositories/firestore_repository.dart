import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/const.dart';
import 'package:domain/entities/user_entity.dart';
import 'package:domain/repositories/remote_store_repository.dart';

class FirestoreRepository implements RemoteStoreRepository {
  final FirebaseFirestore _firestore;

  FirestoreRepository(this._firestore);

  @override
  Future<bool> checkUserExists(UserEntity user) async {
    final collectionRef = _firestore.collection(FirestoreCollectionNames.users);

    final document = await collectionRef
        .where(
          'login',
          isEqualTo: user.login,
        )
        .where(
          'password',
          isEqualTo: user.password,
        )
        .get();

    return document.docs.isNotEmpty;
  }
}

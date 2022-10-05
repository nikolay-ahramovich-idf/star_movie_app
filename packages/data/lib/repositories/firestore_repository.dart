import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/repositories/remote_store_repository.dart';

class FirestoreRepository implements RemoteStoreRepository {
  final FirebaseFirestore _firestore;

  FirestoreRepository(this._firestore);

  @override
  Future<Map<String, dynamic>?> getDocumentDataByValues(
    String collectionName,
    Map<String, dynamic> queryMap,
  ) async {
    final collectionRef = _firestore.collection(collectionName);

    Query<Map<String, dynamic>>? query;

    queryMap.forEach((key, value) {
      query = query == null
          ? collectionRef.where(
              key,
              isEqualTo: value,
            )
          : query?.where(
              key,
              isEqualTo: value,
            );
    });

    final document = await query?.get();

    if (document != null) {
      return document.docs.isNotEmpty ? document.docs.first.data() : null;
    }

    return null;
  }
}

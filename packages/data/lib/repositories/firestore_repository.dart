import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/repositories/remote_store_repository.dart';

class FirestoreService implements RemoteStoreRepository {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<Iterable<Map<String, dynamic>>> getDocuments(
      String collectionPath) async {
    final querySnapshot = await _firestore.collection(collectionPath).get();
    final documents = querySnapshot.docs.map(
      (document) => document.data(),
    );

    return documents;
  }

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

    try {
      return document?.docs.first.data();
    } catch(_) {
      return null;
    }
  }

  @override
  Future<void> createDocument(
    String collectionName,
    Map<String, dynamic> documentData,
  ) async {
    final collectionRef = _firestore.collection(collectionName);
    await collectionRef.add(documentData);
  }
}

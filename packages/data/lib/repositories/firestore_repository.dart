import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/repositories/remote_store_repository.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FirestoreRepository implements RemoteStoreRepository {
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

    // TODO remove later
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final userData = await FacebookAuth.instance.getUserData();

    final fbEmail = userData['email'];
    final id = userData['id']; // create user entity in Firebase

    userData.forEach(
      (key, value) {
        print('$key - $value');
        print(value.runtimeType);
        if (key == 'id') print(value.toString() == "106038345618191");
      },
    );
    print(loginResult.message);
    // TODO remove above

    try {
      return document?.docs.first.data();
    } catch (_) {
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

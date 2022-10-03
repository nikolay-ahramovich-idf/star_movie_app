abstract class RemoteStoreRepository {
  Future<Iterable<Map<String, dynamic>>> getDocuments(
      String collectionPath); // TODO possible remove

  Future<Map<String, dynamic>?> getDocumentDataByValues(
    String collectionName,
    Map<String, dynamic> queryMap,
  );

  Future<void> createDocument(
    String collectionName,
    Map<String, dynamic> documentData,
  );
}

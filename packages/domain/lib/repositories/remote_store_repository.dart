abstract class RemoteStoreRepository {
  Future<Map<String, dynamic>?> getDocumentDataByValues(
    String collectionName,
    Map<String, dynamic> queryMap,
  );
}

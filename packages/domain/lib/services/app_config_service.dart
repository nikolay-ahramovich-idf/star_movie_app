abstract class AppConfigService {
  Future<Map<String, dynamic>> getConfig();

  Future<S> getConfigValue<S>(String key);
}

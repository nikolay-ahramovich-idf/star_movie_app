class FlavorConfig {
  final String appTitle;
  final String apiBaseUrl;
  final String apiKeyConfigKey;

  FlavorConfig(
    this.appTitle, {
    required this.apiBaseUrl,
    required this.apiKeyConfigKey,
  });
}

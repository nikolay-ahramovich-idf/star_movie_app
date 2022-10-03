class FlavorConfig {
  final String appTitle;
  final String apiBaseUrl;
  final String apiKeyConfigKey;

  FlavorConfig(
    this.appTitle, {
    required this.apiBaseUrl,
    required this.apiKeyConfigKey,
  });

  factory FlavorConfig.fromJson(Map<String, dynamic> json) {
    final appTitle = json['appTitle'];
    final apiBaseUrl = json['baseUrl'];
    final apiKeyConfigKey = json['apiKey'];

    return FlavorConfig(
      appTitle,
      apiBaseUrl: apiBaseUrl,
      apiKeyConfigKey: apiKeyConfigKey,
    );
  }
}

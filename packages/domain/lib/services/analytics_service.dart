abstract class AnalyticsService {
  Future<void> logEvent(String eventName, {Map<String, dynamic>? parameters});
}

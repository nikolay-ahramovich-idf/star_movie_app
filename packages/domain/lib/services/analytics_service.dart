abstract class AnalyticsService {
  Future<void> logEvent(String eventName, [String? payload]);
}

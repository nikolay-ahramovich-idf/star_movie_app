import 'dart:async';

import 'package:domain/services/analytics_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsServiceImpl implements AnalyticsService {
  final FirebaseAnalytics _analyticsProvider;

  AnalyticsServiceImpl(this._analyticsProvider);

  @override
  Future<void> logClickEvent(String eventName) async {
    await _analyticsProvider.logEvent(name: eventName);
  }
}

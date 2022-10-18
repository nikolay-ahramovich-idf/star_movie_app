import 'package:domain/services/analytics_service.dart';
import 'package:domain/usecases/usecase.dart';

class LogAnalyticsEventUseCase implements UseCaseParams<String, Future<void>> {
  final AnalyticsService _analyticsService;

  LogAnalyticsEventUseCase(this._analyticsService);

  @override
  Future<void> call(String params) => _analyticsService.logEvent(params);
}

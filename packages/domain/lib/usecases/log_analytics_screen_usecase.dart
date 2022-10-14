import 'package:domain/services/analytics_service.dart';
import 'package:domain/usecases/usecase.dart';

class LogAnalyticsScreenUseCase
    implements UseCaseParams<String?, Future<void>> {
  final AnalyticsService _analyticsService;

  LogAnalyticsScreenUseCase(this._analyticsService);

  @override
  Future<void> call(String? params) async {
    await _analyticsService.logEvent(
      'screen_view',
      parameters: {'payload': params},
    );
  }
}

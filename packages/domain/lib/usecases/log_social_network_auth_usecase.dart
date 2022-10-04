import 'package:domain/services/analytics_service.dart';
import 'package:domain/usecases/usecase.dart';

class LogSocialNetworkAuthUseCase
    implements UseCaseParams<String, Future<void>> {
  final AnalyticsService _analyticsService;

  LogSocialNetworkAuthUseCase(this._analyticsService);

  @override
  Future<void> call(String params) async {
    await _analyticsService.logClickEvent(params);
  }
}

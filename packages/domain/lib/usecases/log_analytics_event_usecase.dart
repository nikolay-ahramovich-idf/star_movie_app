import 'package:domain/entities/event_entity.dart';
import 'package:domain/services/analytics_service.dart';
import 'package:domain/usecases/usecase.dart';

class LogAnalyticsEventUseCase
    implements UseCaseParams<EventEntity, Future<void>> {
  final AnalyticsService _analyticsService;

  LogAnalyticsEventUseCase(this._analyticsService);

  @override
  Future<void> call(EventEntity params) => _analyticsService.logEvent(
        params.eventName,
        parameters: params.parameters,
      );
}

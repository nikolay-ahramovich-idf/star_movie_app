import 'package:domain/services/app_interaction_service.dart';
import 'package:domain/usecases/usecase.dart';

class SetLastAppInteractionTimeUseCase
    implements UseCaseParams<AppInteractionType, Future<void>> {
  final AppInteractionService _appInteractionService;

  SetLastAppInteractionTimeUseCase(this._appInteractionService);

  @override
  Future<void> call(AppInteractionType params) async {
    await _appInteractionService.addLastAppInteractionTime(params);
  }
}

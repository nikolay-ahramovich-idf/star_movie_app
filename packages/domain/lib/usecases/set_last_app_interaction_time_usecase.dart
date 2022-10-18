import 'package:domain/services/app_interaction_service.dart';
import 'package:domain/usecases/usecase.dart';

class SetLastAppInteractionTimeUseCase implements UseCase<Future<void>> {
  final AppInteractionService _appInteractionService;

  SetLastAppInteractionTimeUseCase(this._appInteractionService);

  @override
  Future<void> call() async {
    await _appInteractionService.addLastAppInteractionTime();
  }
}

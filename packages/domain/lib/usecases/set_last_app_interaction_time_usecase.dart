import 'package:domain/entities/db/app_interaction.dart';
import 'package:domain/services/app_interaction_service.dart';
import 'package:domain/usecases/usecase.dart';

class SetLastAppInteractionTimeUseCase
    implements UseCaseParams<AppInteractionType, Future<void>> {
  final AppInteractionService _appInteractionService;

  SetLastAppInteractionTimeUseCase(this._appInteractionService);

  @override
  Future<void> call(AppInteractionType params) async {
    final appInteraction = AppInteraction(
      interactionType: params.index,
      lastTime: DateTime.now().toString(),
    );

    await _appInteractionService.addLastAppInteraction(appInteraction);
  }
}

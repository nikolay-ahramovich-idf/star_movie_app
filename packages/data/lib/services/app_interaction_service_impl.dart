import 'package:data/database/dao/app_interaction_dao.dart';
import 'package:domain/entities/db/app_interaction.dart';
import 'package:domain/services/app_interaction_service.dart';

class AppInteractionServiceImpl implements AppInteractionService {
  static const _lastAppInteractionTimeKey = 'last_app_iteraction_time';

  final AppInteractionDao _appInteractionDao;

  AppInteractionServiceImpl(this._appInteractionDao);

  @override
  Future<void> addLastAppInteraction(
    AppInteraction appInteraction,
  ) async {
    final interaction = await _appInteractionDao.findLastInteractionTime(
      appInteraction.interactionType,
    );

    if (interaction == null) {
      await _appInteractionDao.insertAppInteraction(appInteraction);
    } else {
      await _appInteractionDao.updateLastTime(
        appInteraction.lastTime,
        appInteraction.interactionType,
      );
    }
  }

  @override
  Future<DateTime?> getLastAppInteractionTime(
    AppInteractionType interactionType,
  ) async {
    final interaction = await _appInteractionDao.findLastInteractionTime(
      interactionType.index,
    );

    return interaction == null ? null : DateTime.parse(interaction.lastTime);
  }
}

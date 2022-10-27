import 'package:domain/services/app_interaction_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInteractionServiceImpl implements AppInteractionService {
  static const _lastAppInteractionTimeKey = 'last_app_iteraction_time';

  final SharedPreferences _preferencesProvider;

  AppInteractionServiceImpl(this._preferencesProvider);

  @override
  Future<void> addLastAppInteractionTime(
    AppInteractionType interactionType,
  ) async {
    final now = DateTime.now();

    await _preferencesProvider.setString(
      '${_lastAppInteractionTimeKey}_${interactionType.index}',
      now.toString(),
    );
  }

  @override
  Future<DateTime?> getLastAppInteractionTime(
    AppInteractionType interactionType,
  ) async {
    final lastAppInteractionTime = _preferencesProvider
        .getString('${_lastAppInteractionTimeKey}_${interactionType.index}');

    return lastAppInteractionTime == null
        ? null
        : DateTime.parse(lastAppInteractionTime);
  }
}

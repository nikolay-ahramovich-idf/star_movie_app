import 'package:domain/services/app_interaction_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInteractionServiceImpl implements AppInteractionService {
  final SharedPreferences _preferencesProvider;

  final _lastAppInteractionTimeKey = 'last_app_iteraction_time';

  AppInteractionServiceImpl(this._preferencesProvider);

  @override
  Future<void> addLastAppInteractionTime() async {
    final now = DateTime.now();

    await _preferencesProvider.setString(
      _lastAppInteractionTimeKey,
      now.toString(),
    );
  }

  @override
  Future<DateTime?> getLastAppInteractionTime() async {
    final lastAppInteractionTime =
        _preferencesProvider.getString(_lastAppInteractionTimeKey);

    return lastAppInteractionTime == null
        ? null
        : DateTime.parse(lastAppInteractionTime);
  }
}

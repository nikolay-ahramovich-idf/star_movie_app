abstract class AppInteractionService {
  Future<void> addLastAppInteractionTime();

  Future<DateTime?> getLastAppInteractionTime();
}

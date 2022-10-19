enum AppInteractionType {
  nowShowingMovies,
  comingSoonMovies,
}

abstract class AppInteractionService {
  Future<void> addLastAppInteractionTime(AppInteractionType interactionType);

  Future<DateTime?> getLastAppInteractionTime(
    AppInteractionType interactionType,
  );
}

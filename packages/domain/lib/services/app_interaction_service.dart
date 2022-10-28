import 'package:domain/entities/db/app_interaction.dart';

enum AppInteractionType {
  nowShowingMovies,
  comingSoonMovies,
}

abstract class AppInteractionService {
  Future<void> addLastAppInteraction(AppInteraction appInteraction);

  Future<DateTime?> getLastAppInteractionTime(
    AppInteractionType interactionType,
  );
}

import 'package:domain/entities/db/app_interaction.dart';
import 'package:floor/floor.dart';

@dao
abstract class AppInteractionDao {
  @Query(
      'SELECT * FROM AppInteraction WHERE interactionType = (:interactionType)')
  Future<AppInteraction?> findLastInteractionTime(int interactionType);

  @Query(
      'UPDATE AppInteraction SET lastTime = :newTime WHERE interactionType = :interactionType')
  Future<void> updateLastTime(
    String newTime,
    int interactionType,
  );

  @insert
  Future<void> insertAppInteraction(AppInteraction appInteraction);
}

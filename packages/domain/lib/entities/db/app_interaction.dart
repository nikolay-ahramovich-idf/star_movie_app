import 'package:floor/floor.dart';

@entity
class AppInteraction {
  @PrimaryKey(autoGenerate: true)
  int? id;
  final int interactionType;
  final String lastTime;

  AppInteraction({
    this.id,
    required this.interactionType,
    required this.lastTime,
  });
}

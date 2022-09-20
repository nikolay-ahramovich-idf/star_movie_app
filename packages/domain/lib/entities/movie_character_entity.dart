class MovieCharacterEntity {
  final String characterName;
  final String actorName;
  final int tmdbId;
  final String? posterPath;

  const MovieCharacterEntity({
    required this.characterName,
    required this.actorName,
    required this.tmdbId,
    required this.posterPath,
  });

  MovieCharacterEntity updatePosterPath(String posterPath) {
    return MovieCharacterEntity(
      characterName: characterName,
      actorName: actorName,
      tmdbId: tmdbId,
      posterPath: posterPath,
    );
  }

  factory MovieCharacterEntity.fromJson(Map<String, dynamic> json) {
    final characterName = List<String>.from(json['characters']).first;

    final person = Map<String, dynamic>.from(json['person']);
    final actorName = person['name'] as String;
    final tmdbId = Map<String, dynamic>.from(person['ids'])['tmdb'] as int;

    return MovieCharacterEntity(
      characterName: characterName,
      actorName: actorName,
      tmdbId: tmdbId,
      posterPath: null,
    );
  }
}

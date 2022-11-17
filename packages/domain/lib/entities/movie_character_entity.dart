class MovieCharacterEntity {
  final String roleName;
  final String personName;
  final int tmdbId;
  final String? posterPath;

  const MovieCharacterEntity({
    required this.roleName,
    required this.personName,
    required this.tmdbId,
    required this.posterPath,
  });

  MovieCharacterEntity updatePosterPath(String posterPath) {
    return MovieCharacterEntity(
      roleName: roleName,
      personName: personName,
      tmdbId: tmdbId,
      posterPath: posterPath,
    );
  }

  factory MovieCharacterEntity.fromJson(Map<String, dynamic> json) {
    final roleName = json.containsKey('characters')
        ? List<String>.from(json['characters']).first
        : List<String>.from(json['jobs']).first;

    final person = Map<String, dynamic>.from(json['person']);
    final personName = person['name'] as String;
    final tmdbId = Map<String, dynamic>.from(person['ids'])['tmdb'] as int;

    return MovieCharacterEntity(
      roleName: roleName,
      personName: personName,
      tmdbId: tmdbId,
      posterPath: null,
    );
  }
}

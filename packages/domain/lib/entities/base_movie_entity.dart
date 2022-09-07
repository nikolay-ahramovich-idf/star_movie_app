class BaseMovieEntity {
  final String title;
  final List<String> genres;
  final int runtime;
  final String certification;
  final int tmdbId;

  const BaseMovieEntity(
    this.title, {
    required this.genres,
    required this.runtime,
    required this.certification,
    required this.tmdbId,
  });

  factory BaseMovieEntity.fromJson(Map<String, dynamic> json) {
    final movieJson = json['movie'] as Map<String, dynamic>;

    final title = movieJson['title'] as String;
    final genres = movieJson['genres'] as List<String>;
    final runtime = movieJson['runtime'] as int;
    final certification = movieJson['certification'] as String;
    final tmdbId = movieJson['ids']['tmdb'] as int;

    return BaseMovieEntity(
      title,
      genres: genres,
      runtime: runtime,
      certification: certification,
      tmdbId: tmdbId,
    );
  }
}

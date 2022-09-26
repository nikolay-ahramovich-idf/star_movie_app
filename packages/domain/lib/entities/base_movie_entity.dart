class BaseMovieEntity {
  final String? title;
  final double? rating;
  final List<String>? genres;
  final int? runtime;
  final String? certification;
  final String? overview;
  final int? traktId;
  final String? imdbId;

  const BaseMovieEntity(
    this.title, {
    required this.rating,
    required this.genres,
    required this.runtime,
    required this.certification,
    required this.overview,
    required this.traktId,
    this.imdbId,
  });

  factory BaseMovieEntity.fromJson(Map<String, dynamic> json) {
    final movieJson = json['movie'] as Map<String, dynamic>;

    final title = movieJson['title'];
    final rating = movieJson['rating'];
    final genres = List<String>.from(movieJson['genres']);
    final overview = movieJson['overview'];
    final runtime = movieJson['runtime'];
    final certification = movieJson['certification'];
    final ids = Map.from(movieJson['ids']);
    final traktId = ids['trakt'];
    final imbdId = ids['imdb'] is String ? ids['imdb'] : null;

    return BaseMovieEntity(
      title,
      rating: rating,
      genres: genres,
      runtime: runtime,
      certification: certification,
      overview: overview,
      traktId: traktId,
      imdbId: imbdId,
    );
  }
}

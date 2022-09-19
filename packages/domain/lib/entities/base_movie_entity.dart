class BaseMovieEntity {
  final String? title;
  final double? rating;
  final List<String>? genres;
  final String? runtime;
  final String? certification;
  final String? imdbId;

  const BaseMovieEntity(
    this.title, {
    required this.rating,
    required this.genres,
    required this.runtime,
    required this.certification,
    this.imdbId,
  });

  factory BaseMovieEntity.fromJson(Map<String, dynamic> json) {
    final movieJson = json['movie'] as Map<String, dynamic>;

    final title = movieJson['title'] as String?;
    final rating = movieJson['rating'] as double?;
    final genres = List<String>.from(movieJson['genres']);
    final runtime = _formatApiRuntime(movieJson['runtime'] as int?);
    final certification = movieJson['certification'] as String?;

    final ids = Map.from(movieJson['ids']);
    final imbdId = ids['imdb'] is String ? ids['imdb'] as String : null;

    return BaseMovieEntity(
      title,
      rating: rating,
      genres: genres,
      runtime: runtime,
      certification: certification,
      imdbId: imbdId,
    );
  }

  static String? _formatApiRuntime(int? runtime) {
    if (runtime == null) return null;
    const minutesInHour = 60;
    final minutes = runtime % minutesInHour;
    final hours = (runtime - minutes) / minutesInHour;
    return '${hours}hr ${minutes}m';
  }
}

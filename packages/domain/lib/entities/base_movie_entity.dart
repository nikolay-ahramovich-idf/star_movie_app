enum MoviesType {
  nowShowing,
  comingSoon,
}

class BaseMovieEntity {
  final String? title;
  final double? rating;
  final List<String>? genres;
  final int? runtime;
  final String? certification;
  final String? overview;
  final int traktId;
  final String? imdbId;
  final int? tmdbId;

  const BaseMovieEntity(
    this.title, {
    required this.rating,
    required this.genres,
    required this.runtime,
    required this.certification,
    required this.overview,
    required this.traktId,
    this.imdbId,
    this.tmdbId,
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
    final imdbId = ids['imdb'];
    final tmdbId = ids['tmdb'];

    return BaseMovieEntity(
      title,
      rating: rating,
      genres: genres,
      runtime: runtime,
      certification: certification,
      overview: overview,
      traktId: traktId,
      imdbId: imdbId,
      tmdbId: tmdbId,
    );
  }

  @override
  int get hashCode => title.hashCode;

  @override
  bool operator ==(Object other) {
    return other is BaseMovieEntity &&
        title == other.title &&
        rating == other.rating &&
        certification == other.certification &&
        overview == other.overview &&
        traktId == other.traktId &&
        imdbId == other.imdbId &&
        tmdbId == other.tmdbId;
  }
}

class ShareMovieEntity {
  final String message;
  final String locale;
  final int tmdbId;

  ShareMovieEntity(
    this.message, {
    required this.locale,
    required this.tmdbId,
  });
}

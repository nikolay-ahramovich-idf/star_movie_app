class ShareMovieEntity {
  final String message;
  final String locale;
  final int tmdbId;
  final String intentTitle;

  ShareMovieEntity(
    this.message, {
    required this.locale,
    required this.tmdbId,
    required this.intentTitle,
  });
}

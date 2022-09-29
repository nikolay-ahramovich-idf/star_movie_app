class MoviesResponseEntity {
  List<dynamic>? movies;
  Map<String, List<String>> headers;
  String? errorMessage;

  MoviesResponseEntity(
    this.movies, {
    required this.headers,
    this.errorMessage,
  });
}

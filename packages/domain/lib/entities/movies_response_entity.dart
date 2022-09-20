class MoviesResponseEntity {
  List<dynamic>? movies;
  Map<String, List<String>> headers;

  MoviesResponseEntity(
    this.movies, {
    required this.headers,
  });
}

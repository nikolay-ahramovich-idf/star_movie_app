class MoviesRequestException implements Exception {
  final String _cause;

  MoviesRequestException(this._cause);

  String get errorMessage => _cause;
}

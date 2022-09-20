class DataConfig {
  DataConfig._();
  static const configPath = 'assets/json/config.json';
}

class TraktApiConfig {
  TraktApiConfig._();
  static const apiPath = 'https://api.trakt.tv';

  static const traktApiKeyHeaderName = 'trakt-api-key';
  static const traktApiKeyJsonConfigName = 'traktApiKey';
}

class TraktApiPaths {
  TraktApiPaths._();
  static const nowShowingMovies = '/movies/trending';
  static const comingSoonMovies = '/movies/anticipated';
}

class TraktApiPathsQueryParameters {
  TraktApiPathsQueryParameters._();
  static const Map<String, dynamic> extendedQuery = {'extended': 'full'};
}

class DISingletonInstanceNames {
  DISingletonInstanceNames._();
  static const traktApiDio = 'traktApiDio';
  static const traktApiService = 'traktApiService';

  static const imdbImagesRepository = 'imdbImagesRepository';

  static const tmdbApiDio = 'tmdbApiDio';
  static const tmdbApiService = 'tmdbApiService';
  static const tmdbImagesRepository = 'tmdbImagesRepository';
}

class TMDBConfig {
  static const apiPath = 'https://api.themoviedb.org/3/';
  static const actorPictureApiPath = 'https://image.tmdb.org/t/p/original';

  static const tmdbApiKeyQueryName = 'api_key';
  static const tmdbApiKeyJsonConfigName = 'tmdbApiKey';
}

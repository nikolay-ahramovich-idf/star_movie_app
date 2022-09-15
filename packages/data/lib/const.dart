class DataConfig {
  static const configPath = 'assets/json/config.json';
}

class TraktApiConfig {
  static const apiPath = 'https://api.trakt.tv';

  static const traktApiKeyHeaderName = 'trakt-api-key';
  static const traktApiKeyJsonConfigName = 'traktApiKey';
}

class TraktApiPaths {
  static const nowShowingMovies = '/movies/trending';
  static const comingSoonMovies = '/movies/anticipated';
}

class TraktApiPathsQueryParameters {
  static const Map<String, dynamic> extendedQuery = {'extended': 'full'};
}

class TraktApiSpecialHeaders {
  static const totalMoviesCountHeader = 'X-Pagination-Item-Count';
}

class TraktMovieCounts {
  static const maxMoviesCount = 60;
  static const minAdditionalMoviesCount = 10;
  static const maxAdditionalMoviesCount = 50;
}

class DISingletonInstanceNames {
  static const traktApiDio = 'traktApiDio';
  static const traktApiService = 'traktApiService';
}

const delayInSeconds = 3;

class IMDBConfig {
  IMDBConfig._();
  static const apiScheme = 'http';
  static const apiPath = 'img.omdbapi.com';

  static const imdbApiKeyQueryName = 'apikey';
  static const imdbApiKeyJsonConfigName = 'imdbApiKey';
}

class IMDBQueryParameters {
  IMDBQueryParameters._();
  static const imageQueryKey = 'i';
}

class TraktMovieCounts {
  TraktMovieCounts._();
  static const maxMoviesCount = 60;
  static const minAdditionalMoviesCount = 10;
  static const maxAdditionalMoviesCount = 50;
}

class TraktApiSpecialHeaders {
  TraktApiSpecialHeaders._();
  static const totalMoviesCountHeader = 'X-Pagination-Item-Count';
}

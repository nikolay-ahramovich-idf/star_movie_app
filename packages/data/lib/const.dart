import 'package:dio/dio.dart';

class TraktApiConfig {
  static const apiPath = 'https://api.trakt.tv';

  static const apiHeaders = <String, dynamic>{
    'trakt-api-key':
        '03d54df75db1932571fa3664bf39ab7ba9178861a57958310937f9d51ce37d6f',
    'trakt-api-version': 2,
    'Content-Type': 'application/json',
  };
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

class TMDBConfig {
  static const apiKey = 'c75aefc9adf4486968bb9578ee595f9d';
}

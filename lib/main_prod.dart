import 'package:star_movie_app/flavor_config.dart';

import 'main.dart';

void main() {
  mainCommon(FlavorConfig(
    'TraktTv',
    apiBaseUrl: 'https://api.trakt.tv',
    apiKeyConfigKey: 'traktApiKey',
  ));
}

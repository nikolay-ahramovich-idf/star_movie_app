import 'package:star_movie_app/flavor_config.dart';
import 'package:star_movie_app/main.dart';

void main() {
  mainCommon(FlavorConfig(
    'TraktTv-sandbox',
    apiBaseUrl: 'https://api-staging.trakt.tv',
    apiKeyConfigKey: 'traktApiKeySandbox',
  ));
}

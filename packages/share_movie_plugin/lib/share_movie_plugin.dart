import 'share_movie_plugin_platform_interface.dart';

class ShareMoviePlugin {
  Future<void> shareMovie(
    String message,
    String intentTitle,
  ) async {
    await ShareMoviePluginPlatform.instance.shareMovie(
      message,
      intentTitle,
    );
  }
}

import 'share_movie_plugin_platform_interface.dart';

class ShareMoviePlugin {
  Future<void> shareMovie(String message) async {
    await ShareMoviePluginPlatform.instance.shareMovie(
      message,
    );
  }
}

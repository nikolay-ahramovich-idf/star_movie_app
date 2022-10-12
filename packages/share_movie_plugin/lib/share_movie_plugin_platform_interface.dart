import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'share_movie_plugin_method_channel.dart';

abstract class ShareMoviePluginPlatform extends PlatformInterface {
  ShareMoviePluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static ShareMoviePluginPlatform _instance = MethodChannelShareMoviePlugin();

  static ShareMoviePluginPlatform get instance => _instance;

  static set instance(ShareMoviePluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> shareMovie(String message, String intentTitle) async {
    throw UnimplementedError('share movie not been implimented.');
  }
}

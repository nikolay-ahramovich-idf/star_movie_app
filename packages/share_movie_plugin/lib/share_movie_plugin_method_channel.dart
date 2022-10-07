import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'share_movie_plugin_platform_interface.dart';

class MethodChannelShareMoviePlugin extends ShareMoviePluginPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('share_movie_plugin');

  @override
  Future<void> shareMovie(String message) async {
    try {
      await methodChannel.invokeMethod(
        'shareMovie',
        {'message': message},
      );
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }
}

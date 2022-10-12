import 'package:domain/services/share_movie_service.dart';
import 'package:share_movie_plugin/share_movie_plugin.dart';

class ShareMovieServiceImpl implements ShareMovieService {
  final ShareMoviePlugin _plugin;

  ShareMovieServiceImpl(this._plugin);

  @override
  Future<void> shareMovie(
    String message,
    String intentTitle,
  ) async {
    await _plugin.shareMovie(
      message,
      intentTitle,
    );
  }
}

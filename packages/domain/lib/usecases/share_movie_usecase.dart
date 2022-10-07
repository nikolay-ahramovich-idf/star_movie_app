import 'package:domain/const.dart';
import 'package:domain/entities/share_movie_entity.dart';
import 'package:domain/services/share_movie_service.dart';
import 'package:domain/usecases/usecase.dart';

class ShareMovieUseCase
    implements UseCaseParams<ShareMovieEntity, Future<void>> {
  final ShareMovieService _service;

  ShareMovieUseCase(this._service);

  @override
  Future<void> call(ShareMovieEntity params) async {
    String message =
        '${params.message}\n\n${TMDBConfig.movieApiPath}/${params.tmdbId}?language=${params.locale}';
    await _service.shareMovie(message);
  }
}

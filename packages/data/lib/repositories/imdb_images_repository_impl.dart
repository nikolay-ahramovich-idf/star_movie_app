import 'package:data/const.dart';
import 'package:domain/repositories/images_repository.dart';

class IMDBImagesRepositoryImpl implements ImagesRepository {
  final int _imdbApiKey;

  IMDBImagesRepositoryImpl(this._imdbApiKey);

  @override
  String getImageUrlById(String id) {
    final imageUri = Uri(
      scheme: IMDBConfig.apiScheme,
      host: IMDBConfig.apiPath,
      queryParameters: {
        IMDBConfig.imdbApiKeyQueryName: _imdbApiKey.toString(),
        IMDBQueryParameters.imageQueryKey: id,
      },
    );

    return imageUri.toString();
  }
}

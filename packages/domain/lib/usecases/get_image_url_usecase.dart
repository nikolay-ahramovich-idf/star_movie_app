import 'package:domain/const.dart';
import 'package:domain/usecases/usecase.dart';

class GetImageUrlUsecase extends UseCaseParams<String, String> {
  final String _imdbApiKey;

  GetImageUrlUsecase(this._imdbApiKey);

  @override
  String call(String params) {
    final imageUri = Uri(
      scheme: IMDBConfig.apiScheme,
      host: IMDBConfig.apiPath,
      queryParameters: {
        IMDBConfig.imdbApiKeyQueryName: _imdbApiKey.toString(),
        IMDBQueryParameters.imageQueryKey: params,
      },
    );

    return imageUri.toString();
  }
}

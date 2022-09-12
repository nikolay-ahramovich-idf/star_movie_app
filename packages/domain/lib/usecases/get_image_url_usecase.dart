import 'package:domain/repositories/images_repository.dart';
import 'package:domain/usecases/usecase.dart';

class GetImageUrlUseCase extends UseCaseParams<String, String> {
  final ImagesRepository _imagesRepository;

  GetImageUrlUseCase(this._imagesRepository);

  @override
  String call(String params) {
    return _imagesRepository.getImageUrlById(params);
  }
}

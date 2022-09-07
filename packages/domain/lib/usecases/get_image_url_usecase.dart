import 'package:domain/repositories/images_repository.dart';
import 'package:domain/usecases/usecase.dart';

class GetImageUrlUseCase extends UseCaseParams<int, String> {
  final ImagesRepository _imagesRepository;

  GetImageUrlUseCase(this._imagesRepository);

  @override
  String call(int params) {
    return _imagesRepository.getImageById(params);
  }
}

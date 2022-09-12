import 'package:domain/usecases/usecase.dart';

class ConvertApiRuntimeUsecase extends UseCaseParams<int, String> {
  static const minutesPerHour = 60;

  @override
  String call(int params) {
    final minutes = params % minutesPerHour;
    final hours = (params - minutes) / minutesPerHour;
    return '${hours}hr ${minutes}m';
  }
}

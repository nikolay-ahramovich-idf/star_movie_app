import 'package:domain/const.dart';
import 'package:domain/usecases/usecase.dart';

class DelayUseCase implements UseCase<Future<void>> {
  @override
  Future<void> call() async {
    await Future.delayed(
      const Duration(
        seconds: delayInSeconds,
      ),
    );
  }
}

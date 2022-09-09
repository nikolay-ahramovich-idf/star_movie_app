import 'package:domain/usecases/delay_usecase.dart';
import 'package:get_it/get_it.dart';

void initDomainInjector() {
  _initUsecaseModule();
}

void _initUsecaseModule() {
  GetIt.I.registerFactory<DelayUsecase>(() => DelayUsecase());
}

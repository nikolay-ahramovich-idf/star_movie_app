abstract class UseCase<Output> {
  Future<Output> call();
}

abstract class UseCaseParams<Params, Output> {
  Output call(Params params);
}

abstract class UseCase<Output> {
  Output call();
}

abstract class UseCaseParams<Params, Output> {
  Output call(Params params);
}

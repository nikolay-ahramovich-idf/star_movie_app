import 'package:presentation/navigation/base_arguments.dart';

abstract class Bloc<T extends BaseArguments, S> {
  S get state;
  set state(S newState);
  Stream<S?> get stream;

  void initState();

  void initArgs(T args);

  void add(S data);

  void dispose();
}

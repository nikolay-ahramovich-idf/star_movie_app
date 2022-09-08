abstract class Bloc<S> {
  S get state;
  set state(S newState);
  Stream<S?> get stream;

  void initState();
  void add(S data);
  void dispose();
}

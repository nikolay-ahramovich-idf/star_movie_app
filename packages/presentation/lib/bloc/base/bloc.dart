abstract class Bloc<State> {
  initState();
  State? get state;
  set state(State? newState);
  Stream<State> get stream;
  void add(dynamic data);
  void dispose();
}

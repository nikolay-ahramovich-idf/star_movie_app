import 'dart:async';
import 'package:meta/meta.dart';
import 'package:presentation/bloc/base/bloc.dart';

abstract class BlocImpl<State> implements Bloc<State> {
  final _dataStreamController = StreamController<State>();

  State? _state;

  @override
  @protected
  State? get state => _state;

  @override
  @protected
  set state(State? newState) => _state = newState;

  @override
  Stream<State> get stream => _dataStreamController.stream;

  @override
  void add(dynamic data) {
    _dataStreamController.add(data);
  }

  @override
  void dispose() async {
    await _dataStreamController.close();
  }
}

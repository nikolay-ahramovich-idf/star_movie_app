import 'dart:async';
import 'package:meta/meta.dart';
import 'package:presentation/bloc/base/bloc.dart';
import 'package:presentation/navigation/app_navigator.dart';
import 'package:get_it/get_it.dart';

abstract class BlocImpl<S> implements Bloc<S> {
  final _dataStreamController = StreamController<S?>();
  S _state;

  BlocImpl({required S initState}) : _state = initState;

  @override
  @protected
  S get state => _state;

  @override
  @protected
  set state(S newState) => _state = newState;

  @protected
  final appNavigator = GetIt.I.get<AppNavigator>();

  @override
  Stream<S?> get stream => _dataStreamController.stream;

  @override
  void add(S data) {
    // TODO possible remove possible not
    _state = state;
    _dataStreamController.add(data);
  }

  @override
  void dispose() async {
    await _dataStreamController.close();
  }
}

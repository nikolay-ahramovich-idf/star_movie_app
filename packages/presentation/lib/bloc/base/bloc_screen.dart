import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/bloc/base/bloc.dart';

abstract class BlocScreenState<BS extends StatefulWidget, B extends Bloc>
    extends State<BS> {
  final B bloc = GetIt.I.get<B>();

  @override
  void initState() {
    super.initState();
    bloc.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}

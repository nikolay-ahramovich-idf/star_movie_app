import 'package:flutter/material.dart';
import 'base_arguments.dart';

class BasePage<T extends BaseArguments> extends Page {
  const BasePage({
    required LocalKey key,
    required String name,
    required this.builder,
    T? arguments,
  }) : super(key: key, name: name, arguments: arguments);

  final WidgetBuilder builder;

  @override
  Route createRoute(BuildContext context) => MaterialPageRoute(
        settings: this,
        builder: builder,
      );

  @override
  String toString() => '$name';
}

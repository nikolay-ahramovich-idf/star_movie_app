import 'package:flutter/material.dart';
import 'base_arguments.dart';

class BasePage<T extends BaseArguments> extends Page {
  const BasePage({
    @required required LocalKey key,
    @required required String name,
    @required required this.builder,
    this.showSlideAnim,
    T? arguments,
  }) : super(key: key, name: name, arguments: arguments);

  final WidgetBuilder builder;
  final bool? showSlideAnim;

  @override
  Route createRoute(BuildContext context) => _AppRoute(
        settings: this,
        builder: builder,
        showSlideAnim: showSlideAnim == true,
      );

  @override
  String toString() => '$name';
}

class _AppRoute extends MaterialPageRoute {
  final bool showSlideAnim;

  _AppRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    this.showSlideAnim = false,
  }) : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (!showSlideAnim) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    }

    return super.buildTransitions(
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }
}

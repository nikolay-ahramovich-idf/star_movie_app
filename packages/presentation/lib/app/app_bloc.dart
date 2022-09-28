import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:presentation/app/data/app_data.dart';
import 'package:presentation/bloc/base/bloc.dart';
import 'package:presentation/bloc/base/bloc_impl.dart';
import 'package:presentation/navigation/base_arguments.dart';
import 'package:presentation/navigation/base_page.dart';
import 'package:presentation/screens/home/home_screen.dart';

abstract class AppBloc implements Bloc<BaseArguments, AppData> {
  factory AppBloc() => _AppBloc();

  void handleRemoveRouteSettings(RouteSettings value);

  void goToHomePage();
}

class _AppBloc extends BlocImpl<BaseArguments, AppData> implements AppBloc {
  _AppBloc() : super(initState: AppData.init());

  @override
  void initState() {
    _initNavHandler();
    _updateData();
  }

  @override
  void handleRemoveRouteSettings(RouteSettings value) {
    state.pages.remove(value);
    _updateData();
  }

  @override
  void goToHomePage() {
    _popUntil(HomeScreen.page());
  }

  void _initNavHandler() {
    appNavigator.init(
      push: _push,
      popOldAndPush: _popOldAndPush,
      popAllAndPush: _popAllAndPush,
      popAndPush: _popAndPush,
      pushPages: _pushPages,
      popAllAndPushPages: _popAllAndPushPages,
      pop: _pop,
      maybePop: _maybePop,
      popUntil: _popUntil,
      currentPage: _currentPage,
    );
  }

  void _push(BasePage page) {
    state.pages.add(page);
    _updateData();
  }

  void _popAllAndPush(BasePage page) {
    state.pages.clear();
    _push(page);
  }

  void _popOldAndPush(BasePage page) {
    final oldIndex = state.pages.indexWhere(
      (element) => element.name == page.name,
    );
    if (oldIndex != -1) {
      state.pages.removeAt(oldIndex);
    }
    _push(page);
  }

  void _popAndPush(BasePage page) {
    state.pages.removeLast();
    _push(page);
  }

  void _pushPages(List<BasePage> pages) {
    pages.forEach(state.pages.add);
    _updateData();
  }

  void _popAllAndPushPages(List<BasePage> pages) {
    state.pages.clear();
    pages.forEach(state.pages.add);
    _updateData();
  }

  void _pop() {
    state.pages.removeLast();
    _updateData();
  }

  void _maybePop() {
    if (state.pages.length > 1) {
      _pop();
    }
  }

  void _popUntil(BasePage page) {
    final start = state.pages.indexWhere((e) => e.name == page.name) + 1;
    final end = state.pages.length;
    state.pages.removeRange(start, end);
    _updateData();
  }

  BasePage? _currentPage() => state.pages.lastOrNull;

  void _updateData() {
    super.add(state);
  }
}

import 'package:flutter/material.dart';
import 'package:presentation/app/app_bloc.dart';
import 'package:presentation/app/data/app_data.dart';
import 'package:presentation/app/widgets/tabbar_widget.dart';
import 'package:presentation/screens/splash/splash_screen.dart';

class MobileRootWidget extends StatelessWidget {
  final AppData data;
  final AppBloc bloc;

  const MobileRootWidget({
    required this.data,
    required this.bloc,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Navigator(
        onPopPage: (
          Route<dynamic> route,
          dynamic result,
        ) {
          bloc.handleRemoveRouteSettings(route.settings);
          return route.didPop(result);
        },
        pages: data.pages.toList(),
      ),
      bottomNavigationBar: Visibility(
        visible: data.pages.last.key != SplashScreen.page().key,
        child: TabBarWidget(
          data.currentPageIndex,
          loadPage: bloc.loadPage,
          isDesktop: false,
        ),
      ),
    );
  }
}

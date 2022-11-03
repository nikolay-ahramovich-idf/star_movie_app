import 'package:flutter/material.dart';
import 'package:presentation/app/app_bloc.dart';
import 'package:presentation/app/data/app_data.dart';
import 'package:presentation/app/widgets/tabbar_widget.dart';
import 'package:presentation/utils/dimensions.dart';

class DesktopRootWidget extends StatelessWidget {
  final AppData data;
  final AppBloc bloc;

  const DesktopRootWidget({
    required this.data,
    required this.bloc,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: AppSizes.size70,
        child: TabBarWidget(
          data.currentPageIndex,
          loadPage: bloc.loadPage,
          isDesktop: true,
        ),
      ),
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
    );
  }
}

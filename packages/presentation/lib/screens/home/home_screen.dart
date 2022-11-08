import 'package:flutter/material.dart';
import 'package:presentation/bloc/base/bloc_screen.dart';
import 'package:presentation/navigation/base_page.dart';
import 'package:presentation/screens/home/home_bloc.dart';
import 'package:presentation/screens/home/widgets/desktop_home_widget.dart';
import 'package:presentation/screens/home/widgets/mobile_home_widget.dart';
import 'package:presentation/utils/responsive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const _routeName = '/HomeScreen';

  static String get routeName => _routeName;

  static BasePage page() => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (_) => const HomeScreen(),
      );

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BlocScreenState<HomeScreen, HomeBloc> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    final drawerWidget = getDrawerWidget(context);

    if (isDesktop) {
      return DesktopHomeWidget(
        bloc: bloc,
        drawerWidget: drawerWidget,
      );
    }

    return MobileHomeWidget(
      bloc: bloc,
      drawerWidget: drawerWidget,
    );
  }

  Widget? getDrawerWidget(BuildContext context) {
    final ancestorScaffold = context.findAncestorWidgetOfExactType<Scaffold>();
    return ancestorScaffold?.drawer;
  }
}

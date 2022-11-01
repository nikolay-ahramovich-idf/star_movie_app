import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:presentation/app/app_bloc.dart';
import 'package:presentation/app/widgets/tabbar_widget.dart';
import 'package:presentation/bloc/base/bloc_screen.dart';
import 'package:presentation/screens/splash/splash_screen.dart';
import 'package:presentation/utils/responsive.dart';

class StarMovieApp extends StatefulWidget {
  final String title;

  const StarMovieApp(this.title, {super.key});

  @override
  State<StarMovieApp> createState() => _StarMovieAppState();
}

class _StarMovieAppState extends BlocScreenState<StarMovieApp, AppBloc> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: StreamBuilder(
        stream: bloc.stream,
        builder: (context, snapshot) {
          final screenType = Responsive.getScreenType(context);

          final appData = snapshot.data;

          if (appData != null) {
            final tabBarWidget = TabBarWidget(
              appData.currentPageIndex,
              loadPage: bloc.loadPage,
            );

            return Scaffold(
              drawer: screenType == ScreenType.desktop ? tabBarWidget : null,
              body: Navigator(
                onPopPage: (
                  Route<dynamic> route,
                  dynamic result,
                ) {
                  bloc.handleRemoveRouteSettings(route.settings);
                  return route.didPop(result);
                },
                pages: appData.pages.toList(),
              ),
              bottomNavigationBar: Visibility(
                visible: screenType == ScreenType.mobile &&
                    appData.pages.last.key != SplashScreen.page().key,
                child: tabBarWidget,
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

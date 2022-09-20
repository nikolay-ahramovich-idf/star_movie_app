import 'package:flutter/material.dart';
import 'package:presentation/app/app_bloc.dart';
import 'package:presentation/app/widgets/tabbar_widget.dart';
import 'package:presentation/bloc/base/bloc_screen.dart';
import 'package:presentation/screens/splash/splash_screen.dart';

class StarMovieApp extends StatefulWidget {
  const StarMovieApp({super.key});

  @override
  State<StarMovieApp> createState() => _StarMovieAppState();
}

class _StarMovieAppState extends BlocScreenState<StarMovieApp, AppBloc> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: bloc.stream,
        builder: (context, snapshot) {
          final appData = snapshot.data;
          if (appData != null) {
            return Scaffold(
              body: Navigator(
                onPopPage: (Route<dynamic> route, dynamic result) {
                  bloc.handleRemoveRouteSettings(route.settings);
                  return route.didPop(result);
                },
                pages: appData.pages.toList(),
              ),
              bottomNavigationBar: Visibility(
                visible: appData.pages.last.key != SplashScreen.page().key,
                child: TabBarWidget(
                  bloc.goToHomePage,
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

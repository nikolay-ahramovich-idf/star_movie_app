import 'package:flutter/material.dart';
import 'package:presentation/screens/splash_screen.dart';

class StarMovieApp extends StatelessWidget {
  const StarMovieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Navigator(
        pages: [
          SplashScreen.page(),
        ],
        onPopPage: (route, result) => route.didPop(result),
      ),
    );
  }
}

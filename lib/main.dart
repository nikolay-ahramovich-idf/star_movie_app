import 'package:flutter/material.dart';
import 'package:presentation/app/star_movie_app.dart';
import 'package:star_movie_app/di/app_injector.dart';
import 'package:star_movie_app/flavor_config.dart';

Future<void> mainCommon(FlavorConfig flavorConfig) async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppInjector(flavorConfig);
  runApp(StarMovieApp(
    flavorConfig.appTitle,
  ));
}

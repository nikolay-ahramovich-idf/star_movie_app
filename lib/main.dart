import 'package:flutter/material.dart';
import 'package:presentation/app/star_movie_app.dart';
import 'package:star_movie_app/di/app_injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppInjector();
  runApp(const StarMovieApp());
}

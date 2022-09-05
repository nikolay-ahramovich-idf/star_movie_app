import 'package:flutter/material.dart';
import 'package:presentation/star_movie_app.dart';
import 'package:star_movie_app/di/app_injector.dart';

Future<void> main() async {
  await initAppInjector();
  runApp(const StarMovieApp());
}

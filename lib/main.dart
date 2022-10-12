import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:presentation/app/star_movie_app.dart';
import 'package:star_movie_app/di/app_injector.dart';
import 'package:star_movie_app/environment.dart';
import 'package:star_movie_app/flavor_config.dart';

Future<void> mainCommon(Environment envs) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if (!kDebugMode) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }

  final flavorConfigResource = await readJson(envs.name);
  final flavorConfig = FlavorConfig.fromJson(flavorConfigResource);

  await initAppInjector(flavorConfig);
  runApp(StarMovieApp(flavorConfig.appTitle));
}

Future<Map<String, dynamic>> readJson(String env) async {
  final String response = await rootBundle.loadString(
    'resources/flavors_config/${env}_config.json',
  );

  final Map<String, dynamic> data = await json.decode(response);

  return data;
}

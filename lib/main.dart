import 'package:flutter/material.dart';
import 'package:star_movie_app/di/app_injector.dart';

Future<void> main() async {
  await initAppInjector();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(),
    );
  }
}

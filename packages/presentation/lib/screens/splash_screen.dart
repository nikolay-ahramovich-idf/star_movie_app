import 'package:flutter/material.dart';
import 'package:presentation/navigation/base_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const _routeName = '/SplashScreen';

  static BasePage page() => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (contex) => const SplashScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}

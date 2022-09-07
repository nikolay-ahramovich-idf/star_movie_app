import 'package:flutter/material.dart';
import 'package:presentation/navigation/base_page.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static const _routeName = '/MainScreen';

  static BasePage page() => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (contex) => const MainScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Main Screen'),
      ),
    );
  }
}
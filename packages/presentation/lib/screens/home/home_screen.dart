import 'package:flutter/material.dart';
import 'package:presentation/navigation/base_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _routeName = '/HomeScreen';

  static BasePage page() => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (_) => const HomeScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}

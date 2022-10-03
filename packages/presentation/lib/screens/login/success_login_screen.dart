import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:presentation/navigation/base_page.dart';

class SuccessLoginScreen extends StatelessWidget {
  const SuccessLoginScreen({super.key});

  static const _routeName = '/SuccessLoginScreen';

  static BasePage page() => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (_) => const SuccessLoginScreen(),
      );

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: Center(child: Text(appLocalizations.loginIsSuccessLabel)),
    );
  }
}

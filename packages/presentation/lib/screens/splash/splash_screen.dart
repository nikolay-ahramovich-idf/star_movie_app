import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:presentation/bloc/base/bloc_screen.dart';
import 'package:presentation/const.dart';
import 'package:presentation/navigation/base_page.dart';
import 'package:presentation/screens/splash/splash_bloc.dart';
import 'package:presentation/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const _routeName = '/SplashScreen';

  static BasePage page() => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (contex) => const SplashScreen(),
      );

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends BlocScreenState<SplashScreen, SplashBloc> {
  @override
  Widget build(BuildContext context) {
    _setUiOverlayStyle();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: SplashScreenColors.splashScreenGradient,
        ),
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Image(
            image: AssetImage(
              AssetsImagesPaths.splashScreenMainImagePath,
            ),
          ),
        ),
      ),
    );
  }

  void _setUiOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor:
            SplashScreenColors.splashScreenEndColorGradient,
        statusBarBrightness: Brightness.dark,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const primaryColor = Color.fromARGB(255, 15, 27, 43);
  static const transparentWhite = Color.fromRGBO(255, 255, 255, 0.5);
  static const white = Colors.white;
  static const grey = Colors.grey;
}

class SplashScreenColors {
  SplashScreenColors._();
  static const splashScreenStartColorGradient =
      Color.fromARGB(255, 229, 25, 25);
  static const splashScreenEndColorGradient = Color.fromARGB(255, 219, 82, 82);

  static const splashScreenGradient = [
    splashScreenStartColorGradient,
    splashScreenEndColorGradient,
  ];
}

class HomeScreenColors {
  HomeScreenColors._();
  static const searchIconButtonColor = AppColors.white;
  static const selectionBorderColor = Color.fromARGB(255, 44, 63, 91);
  static const selectionActiveColor = Color.fromARGB(255, 217, 37, 29);
  static const selectionInactiveColor = Colors.transparent;
  static const bottomNavBarIconColorActive = Color.fromARGB(255, 71, 207, 255);
  static const bottomNavBarIconColorInactive = AppColors.transparentWhite;
}

class ShimmerLoaderWidgetColors {
  ShimmerLoaderWidgetColors._();
  static const fillColor = AppColors.grey;
  static final baseColor = AppColors.grey[400]!;
  static final hightlightColor = AppColors.grey[300]!;
}

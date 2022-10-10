import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const primaryColor = Color.fromARGB(255, 15, 27, 43);
  static const transparentWhite50 = Color.fromRGBO(255, 255, 255, 0.5);
  static const transparentWhite70 = Color.fromRGBO(255, 255, 255, 0.7);
  static const white = Colors.white;
  static const grey = Colors.grey;
  static const lightBlue = Color.fromARGB(255, 71, 207, 255);
  static const gold = Color.fromARGB(255, 255, 192, 69);
  static const red = Color.fromARGB(255, 229, 25, 55);
  static const dividersColor = Color.fromRGBO(44, 63, 91, 1);
  static const fillColor = Colors.grey;
  static final baseColor = Colors.grey[400]!;
  static final hightlightColor = Colors.grey[300]!;
}

class LoginScreenColors {
  LoginScreenColors._();

  static const inputFieldBackgroundColor = Color.fromRGBO(43, 53, 67, 1);
  static const twitterColor = Color.fromRGBO(26, 169, 255, 1);
  static const facebookColor = Color.fromRGBO(59, 90, 154, 1);
  static const googleColor = Color.fromRGBO(203, 62, 45, 1);
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
  static const searchIconButtonColor = Colors.white;
  static const selectionBorderColor = Color.fromARGB(255, 44, 63, 91);
  static const selectionActiveColor = Color.fromARGB(255, 217, 37, 29);
  static const selectionInactiveColor = Colors.transparent;
  static const bottomNavBarIconColorActive = Color.fromARGB(255, 71, 207, 255);
  static const bottomNavBarIconColorInactive = AppColors.transparentWhite50;
}

class RatingWidgetColors {
  static const starColor = Color.fromARGB(255, 255, 192, 69);
}

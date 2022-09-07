import 'package:flutter/material.dart';

const packageName = 'presentation';

const splashScreenMainImagePath = 'assets/torch-light.png';
const splashScreenStartColorGradient = Color.fromARGB(255, 229, 25, 25);
const splashScreenEndColorGradient = Color.fromARGB(255, 219, 82, 82);

class AppFonts {
  static const sfProTextFontName = '.SF Pro Text';
}

class AppSizes {
  static const double size3 = 3;
  static const double size8 = 8;
  static const double size10 = 10;
  static const double size13 = 13;
  static const double size15 = 15;
  static const double size20 = 20;
  static const double size24 = 24;
  static const double size29 = 29;
}

class HomeScreenColors {
  static const primaryColor = Color.fromARGB(255, 15, 27, 43);
  static const searchIconButtonColor = Colors.white;
  static const selectionBorderColor = Color.fromARGB(255, 44, 63, 91);
  static const bottomNavBarIconColorActive = Color.fromARGB(255, 71, 207, 255);
  static const bottomNavBarIconColorInactive =
      Color.fromRGBO(255, 255, 255, 0.5);
}

class HomeScreenSizes {
  static const double horizontalPaddingSize = 18;
  static const double searchIconSize = 35;
  static const double selectionBorderRadiusSize = 30;
  static const double selectionBorderWidth = 2;
  static const double bottomNavBarIconSize = 30;
}

class HomeScreenStyles {
  static const appBarStyle = TextStyle(
    fontSize: 28,
    fontFamily: AppFonts.sfProTextFontName,
  );
}

class RatingWidgetConfig {
  static const starColor = Color.fromARGB(255, 255, 192, 69);
  static const double starSize = 14;
  static const double minCurrentRating = 0;
  static const double maxCurrentRating = 10;
}

class MovieCardWidget {
  static const movieNameTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontFamily: AppFonts.sfProTextFontName,
  );

  static const movieAdditionalInfoTextStyle = TextStyle(
    color: Color.fromRGBO(255, 255, 255, 0.5),
    fontSize: 12,
    fontFamily: AppFonts.sfProTextFontName,
  );
}

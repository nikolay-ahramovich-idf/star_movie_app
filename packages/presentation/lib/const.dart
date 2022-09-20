import 'package:flutter/material.dart';

class AppFonts {
  AppFonts._();
  static const sfProTextFontName = '.SF Pro Text';
}

class AppSizes {
  AppSizes._();
  static const double size0 = 0;
  static const double size0point5 = 0.5;
  static const double size2 = 2;
  static const double size3 = 3;
  static const double size4 = 4;
  static const double size6 = 6;
  static const double size8 = 8;
  static const double size9 = 9;
  static const double size10 = 10;
  static const double size12 = 12;
  static const double size13 = 13;
  static const double size14 = 14;
  static const double size15 = 15;
  static const double size16 = 16;
  static const double size18 = 18;
  static const double size20 = 20;
  static const double size24 = 24;
  static const double size29 = 29;
  static const double size32 = 32;
  static const double size35 = 35;
  static const double size45 = 45;
  static const double size49 = 49;
  static const double size50 = 50;
  static const double size56 = 56;
  static const double size57 = 57;
  static const double size282 = 282;

  static const double screensHorizontalPadding = 18;
}

class AppColors {
  AppColors._();
  static const primaryColor = Color.fromARGB(255, 15, 27, 43);
  static const transparentWhite = Color.fromRGBO(255, 255, 255, 0.5);
  static const white = Colors.white;
  static const grey = Colors.grey;
}

class AssetsImagesPaths {
  AssetsImagesPaths._();
  static const playButtonPath = 'assets/play-button.png';
  static const splashScreenMainImagePath = 'assets/torch-light.png';
  static const respondArrow = 'assets/respond-arrow.png';
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
  static const bottomNavBarIconColorInactive = AppColors.transparentWhite;
}

class HomeScreenSizes {
  HomeScreenSizes._();
  static const double horizontalPaddingSize = 18;
  static const double searchIconSize = 35;
  static const double selectionBorderRadiusSize = 30;
  static const double selectionBorderWidth = 2;
  static const double gridChildAspecRatio = 1 / 2.15;
  static const double gridViewMainAxisSpacing = 30;
  static const double bottomNavBarIconSize = 30;
}

class HomeScreenStyles {
  HomeScreenStyles._();
  static const appBarStyle = TextStyle(
    fontSize: 28,
    fontFamily: AppFonts.sfProTextFontName,
  );
}

class MovieDetailsScreenSizes {
  static const double ratingStarSize = 24;
  static const double navigationIconSize = 21;
}

class MovieDetailsScreenStyles {
  static const movieNameStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    fontFamily: AppFonts.sfProTextFontName,
    color: AppColors.white,
  );

  static const movieAdditionalDataStyle = TextStyle(
    fontSize: 16,
    fontFamily: AppFonts.sfProTextFontName,
    color: AppColors.transparentWhite,
  );

  static const movieDescriptionHeaderStyle = TextStyle(
    fontSize: 18,
    fontFamily: AppFonts.sfProTextFontName,
    color: AppColors.white,
  );

  static final movieDescriptionBodyStyle = TextStyle(
    height: 2,
    fontSize: 14,
    fontFamily: AppFonts.sfProTextFontName,
    color: AppColors.white.withOpacity(0.7),
  );

  static final movieDescriptionCastNameStyle =
      movieDescriptionHeaderStyle.copyWith(fontSize: 14);

  static final movieDescriptionRoleNameStyle =
      movieAdditionalDataStyle.copyWith(fontSize: 12);

  static const showMoreStyle = TextStyle(
    fontSize: 14,
    fontFamily: AppFonts.sfProTextFontName,
    color: Color.fromRGBO(71, 207, 255, 1),
  );
}

class MovieDetailsScreenConfig {
  static const int maxCastCount = 4;
}

class RatingWidgetConfig {
  RatingWidgetConfig._();
  static const starColor = Color.fromARGB(255, 255, 192, 69);
  static const double starSize = 16;
  static const fullModeRatingStyle = TextStyle(
    fontSize: 30,
    color: AppColors.white,
  );

  static const double minCurrentRating = 0;
  static const double maxCurrentRating = 10;
}

class SelectionButtonStyles {
  SelectionButtonStyles._();
  static const activeButtonTextStyle = TextStyle(
    color: AppColors.white,
    fontFamily: AppFonts.sfProTextFontName,
    fontSize: AppSizes.size14,
  );

  static const inactiveButtonTextStyle = TextStyle(
    color: AppColors.transparentWhite,
    fontFamily: AppFonts.sfProTextFontName,
    fontSize: AppSizes.size14,
  );
}

class MovieCardWidgetStyles {
  MovieCardWidgetStyles._();
  static const movieNameTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontFamily: AppFonts.sfProTextFontName,
  );

  static const movieAdditionalInfoTextStyle = TextStyle(
    color: AppColors.transparentWhite,
    fontSize: 12,
    fontFamily: AppFonts.sfProTextFontName,
  );
}

class ShimmerLoaderWidgetColors {
  ShimmerLoaderWidgetColors._();
  static const fillColor = Colors.grey;
  static final baseColor = Colors.grey[400]!;
  static final hightlightColor = Colors.grey[300]!;
}

class ImageWidgetStyles {
  ImageWidgetStyles._();
  static const imageNotExistStyle = TextStyle(
    color: AppColors.white,
  );
}

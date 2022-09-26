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
  static const double size30 = 30;
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
  static const transparentWhite50 = Color.fromRGBO(255, 255, 255, 0.5);
  static const transparentWhite70 = Color.fromRGBO(255, 255, 255, 0.7);
  static const white = Colors.white;
  static const grey = Colors.grey;
  static const lightBlue = Color.fromARGB(255, 71, 207, 255);
  static const gold = Color.fromARGB(255, 255, 192, 69);
  static const fillColor = Colors.grey;
  static final baseColor = Colors.grey[400]!;
  static final hightlightColor = Colors.grey[300]!;
}

class AppStyles {
  AppStyles._();

  static TextStyle white(
    double fontSize, {
    String fontFamily = AppFonts.sfProTextFontName,
    FontWeight fontWeight = FontWeight.normal,
    TextDecoration decoration = TextDecoration.none,
    FontStyle fontStyle = FontStyle.normal,
    double opacity = 1,
    double? height,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontStyle: fontStyle,
      color: Colors.white.withOpacity(
        opacity,
      ),
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: decoration,
      height: height,
    );
  }
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
  static const bottomNavBarIconColorInactive = AppColors.transparentWhite50;
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
  static final appBarStyle = AppStyles.white(AppSizes.size29);
}

class MovieDetailsScreenSizes {
  MovieDetailsScreenSizes._();
  static const double ratingStarSize = 24;
  static const double navigationIconSize = 21;
}

class MovieDetailsScreenStyles {
  MovieDetailsScreenStyles._();

  static final movieNameStyle = AppStyles.white(
    AppSizes.size24,
    fontWeight: FontWeight.w600,
  );

  static final movieAdditionalDataStyle = AppStyles.white(
    AppSizes.size15,
    opacity: 0.5,
  );

  static final movieDescriptionHeaderStyle = AppStyles.white(
    AppSizes.size18,
  );

  static final movieDescriptionBodyStyle = AppStyles.white(
    AppSizes.size14,
    height: 2,
    opacity: 0.7,
  );

  static final movieDescriptionCastNameStyle = AppStyles.white(
    AppSizes.size14,
  );

  static final movieDescriptionRoleNameStyle = AppStyles.white(
    AppSizes.size12,
    opacity: 0.5,
  );

  static const showMoreStyle = TextStyle(
    fontSize: AppSizes.size14,
    fontFamily: AppFonts.sfProTextFontName,
    color: AppColors.lightBlue,
  );
}

class MovieDetailsScreenConfig {
  MovieDetailsScreenConfig._();
  static const int maxCastCount = 4;
}

class RatingWidgetConfig {
  RatingWidgetConfig._();
  static const double starSize = 16;
  static final fullModeRatingStyle = AppStyles.white(
    AppSizes.size30,
  );

  static const double minCurrentRating = 0;
  static const double maxCurrentRating = 10;
}

class SelectionButtonStyles {
  SelectionButtonStyles._();
  static final activeButtonTextStyle = AppStyles.white(
    AppSizes.size14,
  );

  static final inactiveButtonTextStyle = AppStyles.white(
    AppSizes.size14,
    opacity: 0.5,
  );
}

class MovieCardWidgetStyles {
  MovieCardWidgetStyles._();
  static final movieNameTextStyle = AppStyles.white(
    AppSizes.size16,
  );

  static final movieAdditionalInfoTextStyle = AppStyles.white(
    AppSizes.size12,
    opacity: 0.5,
  );
}

class ImageWidgetStyles {
  ImageWidgetStyles._();
  static final imageNotExistStyle = AppStyles.white(
    AppSizes.size14,
  );
}

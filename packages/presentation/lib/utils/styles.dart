import 'package:flutter/material.dart';
import 'package:presentation/utils/colors.dart';
import 'package:presentation/utils/dimensions.dart';
import 'package:presentation/utils/fonts.dart';

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

class HomeScreenStyles {
  HomeScreenStyles._();
  static final appBarStyle = AppStyles.white(AppSizes.size29);

  static final white24Style = AppStyles.white(AppSizes.size24);
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

  static final movieDescriptionHeaderStyle = AppStyles.white(AppSizes.size18);

  static final movieDescriptionBodyStyle = AppStyles.white(
    AppSizes.size14,
    height: 2,
    opacity: 0.7,
  );

  static final movieDescriptionCastNameStyle = AppStyles.white(AppSizes.size14);

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

class SelectionButtonStyles {
  SelectionButtonStyles._();
  static final activeButtonTextStyle = AppStyles.white(AppSizes.size14);

  static final inactiveButtonTextStyle = AppStyles.white(
    AppSizes.size14,
    opacity: 0.5,
  );
}

class MovieCardWidgetStyles {
  MovieCardWidgetStyles._();
  static final movieNameTextStyle = AppStyles.white(AppSizes.size16);

  static final movieAdditionalInfoTextStyle = AppStyles.white(
    AppSizes.size12,
    opacity: 0.5,
  );
}

class ImageWidgetStyles {
  ImageWidgetStyles._();
  static final imageNotExistStyle = AppStyles.white(AppSizes.size14);
}

class RatingWidgetStyles {
  RatingWidgetStyles._();
  static final fullModeRatingStyle = AppStyles.white(
    AppSizes.size30,
  );
}

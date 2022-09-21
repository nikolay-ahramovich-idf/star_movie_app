import 'package:flutter/material.dart';
import 'package:presentation/utils/colors.dart';
import 'package:presentation/utils/dimensions.dart';
import 'package:presentation/utils/fonts.dart';

class HomeScreenStyles {
  HomeScreenStyles._();
  static const appBarStyle = TextStyle(
    fontSize: 28,
    fontFamily: AppFonts.sfProTextFontName,
  );
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

class ImageWidgetStyles {
  ImageWidgetStyles._();
  static const imageNotExistStyle = TextStyle(
    color: AppColors.white,
  );
}

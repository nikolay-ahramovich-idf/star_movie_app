import 'package:flutter/material.dart';
import 'package:presentation/utils/colors.dart';

class AssetsImagesPaths {
  AssetsImagesPaths._();
  static const playButtonPath = 'assets/play-button.png';
  static const splashScreenMainImagePath = 'assets/torch-light.png';
  static const respondArrow = 'assets/respond-arrow.png';
}

class MovieDetailsScreenConfig {
  static const int maxCastCount = 4;
}

class RatingWidgetConfig {
  // TODO move to styles
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

class Internalization {
  static const appNameLabel = 'Star Movie';
  static const nowShowingCategoryLabel = 'Now Showing';
  static const comingSoonCategoryLabel = 'Coming Soon';

  static const detailCategoryLabel = 'Detail';
  static const reviewsCategoryLabel = 'Reviews';
  static const showtimeCategoryLabel = 'Showtime';
  static const synopsisHeaderLabel = 'Synopsis';
  static const castAndCrewHeaderLabel = 'Cast & Crew';
  static const showMoreButtonLabel = 'Show More';
  static const showLessButtonLabel = 'Show Less';
  static const viewAllButtonLabel = 'View All';

  static const notRatedLabel = 'NR';
}

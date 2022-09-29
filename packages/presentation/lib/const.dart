class AssetsImagesPaths {
  AssetsImagesPaths._();
  static const playButtonPath = 'assets/play-button.png';
  static const splashScreenMainImagePath = 'assets/torch-light.png';
  static const respondArrow = 'assets/respond-arrow.png';
}

class HomeScreenConfig {
  HomeScreenConfig._();
  static const moviesNotAvailableErrorMessage =
      'Movies are not available due to error. Turn to administrator!';
}

class MovieDetailsScreenConfig {
  MovieDetailsScreenConfig._();
  static const int maxCastCount = 4;
}

class RatingWidgetConfig {
  RatingWidgetConfig._();

  static const double minCurrentRating = 0;
  static const double maxCurrentRating = 10;
}

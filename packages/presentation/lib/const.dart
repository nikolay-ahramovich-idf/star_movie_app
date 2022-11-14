class AssetsImagesPaths {
  AssetsImagesPaths._();
  static const playButtonPath = 'assets/play-button.png';
  static const splashScreenMainImagePath = 'assets/torch-light.png';
  static const respondArrow = 'assets/respond-arrow.png';

  static const usernameIconPath = 'assets/username-icon.png';
  static const passwordIconPath = 'assets/password-icon.png';

  static const twitterIconPath = 'assets/twitter-icon.png';
  static const facebookIconPath = 'assets/facebook-icon.png';
  static const googleIconPath = 'assets/google-icon.png';
}

class MovieDetailsScreenConfig {
  MovieDetailsScreenConfig._();
  static const int maxCastCount = 4;
}

class PaymentScreenConfig {
  PaymentScreenConfig._();
  static const int cvvLength = 3;
}

class RatingWidgetConfig {
  RatingWidgetConfig._();

  static const double minCurrentRating = 0;
  static const double maxCurrentRating = 10;
}

class AnalyticsEvents {
  AnalyticsEvents._();

  static const appEvents = _AppEvents();
  static const homeScreenEvents = _HomeScreenEvents();
  static const loginScreenEvents = _LoginScreenEvents();
  static const movieDetailsEvents = _MovieDetailsEvents();
}

class _AppEvents {
  const _AppEvents();

  final buttonTabbarHomeClick = 'btn_tabbar_home_click';
  final buttonTabbarLoginClick = 'btn_tabbar_login_click';
  final screenView = 'screen_view';
}

class _HomeScreenEvents {
  const _HomeScreenEvents();

  final buttonNowShowingMoviesClick = 'btn_now_showing_movies_click';
  final buttonComingSoonMoviesClick = 'btn_coming_soon_movies_click';
  final buttonMoviePosterClick = 'btn_movie_poster_click';
}

class _LoginScreenEvents {
  const _LoginScreenEvents();

  final buttonAuthByLoginClick = 'btn_auth_by_login_click';
  final buttonAuthByFacebookClick = 'btn_auth_by_facebook_click';
  final buttonAuthByGoogleClick = 'btn_auth_by_google_click';
}

class _MovieDetailsEvents {
  const _MovieDetailsEvents();

  final buttonBackClick = 'btn_back_click';
  final buttonShowLessClick = 'btn_show_less_click';
  final buttonShowMoreClick = 'btn_show_more_click';
}

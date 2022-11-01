import 'package:flutter/material.dart';

enum ScreenType {
  mobile,
  desktop,
}

class Responsive {
  static ScreenType getScreenType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < 500) {
      return ScreenType.mobile;
    }

    return ScreenType.desktop;
  }

  static int moviesCountPerScreenSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < 500) {
      return 2;
    } else if (width < 700) {
      return 4;
    } else if (width < 900) {
      return 6;
    } else {
      return 8;
    }
  }
}

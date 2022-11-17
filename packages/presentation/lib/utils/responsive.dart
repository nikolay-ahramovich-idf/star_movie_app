import 'package:flutter/material.dart';
import 'package:presentation/utils/dimensions.dart';

enum ScreenType {
  mobile,
  desktop,
}

class Responsive {
  static double adaptiveSize44(BuildContext context) {
    return isDesktop(context)
        ? AppSizes.size44 * AppSizes.iconsScalerCoefficient
        : AppSizes.size44;
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

  static int rowsCountPerWidgetSize(context) {
    final parentWidth = MediaQuery.of(context).size.width;

    if (parentWidth < 700) {
      return 1;
    }

    if (parentWidth < 1000) {
      return 2;
    }

    if (parentWidth < 1400) {
      return 3;
    }

    return 4;
  }

  static bool isDesktop(BuildContext context) {
    return _getScreenType(context) == ScreenType.desktop;
  }

  static ScreenType _getScreenType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < 500) {
      return ScreenType.mobile;
    }

    return ScreenType.desktop;
  }
}

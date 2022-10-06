import 'package:presentation/navigation/base_page.dart';
import 'package:presentation/screens/splash/splash_screen.dart';

class AppData {
  final List<BasePage> pages;
  int currentPageIndex = 0;

  AppData(this.pages);

  factory AppData.init() {
    final pages = List<BasePage>.from([
      SplashScreen.page(),
    ]);

    return AppData(pages);
  }
}

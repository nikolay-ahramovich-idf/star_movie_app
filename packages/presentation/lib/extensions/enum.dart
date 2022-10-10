import 'package:presentation/app/widgets/tabbar_widget.dart';

extension BottomNavigationItemTypeExt on BottomNavigationItemType {
  static const unsupportedType = 'unsupported bottom nav bar item type';

  static BottomNavigationItemType toType(int index) {
    try {
      return BottomNavigationItemType.values[index];
    } catch (_) {
      throw Exception(unsupportedType);
    }
  }
}

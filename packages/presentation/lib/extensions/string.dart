extension Capitalize on String {
  String capitalize() {
    if (length < 2) toUpperCase();
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}

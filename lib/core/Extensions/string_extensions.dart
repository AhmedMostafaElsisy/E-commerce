extension StringExstensions on String {
  String checkStartWithZero() {
    if (startsWith("0")) {
      return replaceFirst("0", "");
    } else {
      return this;
    }
  }
}

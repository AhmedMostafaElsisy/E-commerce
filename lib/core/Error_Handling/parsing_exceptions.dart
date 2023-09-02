class ParsingException implements Exception {
  String errorException;

  ParsingException({required this.errorException});
  @override
  String toString() {
    return errorException;
  }
}

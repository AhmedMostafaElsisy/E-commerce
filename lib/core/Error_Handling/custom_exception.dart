import 'custom_error.dart';

class CustomException implements Exception {
  CustomError error;

  CustomException({required this.error});

  @override
  String toString() {
    return 'SomeThing Wrong Happen: \n${error.type}';
  }
}

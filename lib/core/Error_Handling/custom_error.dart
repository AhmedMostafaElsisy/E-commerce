import '../Constants/Enums/exception_enums.dart';

class CustomError {
  CustomStatusCodeErrorType type;
  String? errorMassage;

  CustomError({
    this.type = CustomStatusCodeErrorType.init,
    this.errorMassage,
  });

  @override
  String toString() {
    return 'SomeThing Wrong Happen: \n$type';
  }
}

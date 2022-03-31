import 'package:default_repo_app/Data/Enums/exception_enums.dart';


class CustomError {
  CustomStatusCodeErrorType type;
  String? errorMassage;
  String? imgPath;

  CustomError(
      {this.type = CustomStatusCodeErrorType.init,
      this.errorMassage,
      this.imgPath});

  @override
  String toString() {
    return 'SomeThing Wrong Happen: \n$type';
  }
}

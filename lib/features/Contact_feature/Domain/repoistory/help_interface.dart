import 'package:dartz/dartz.dart';

import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/model/base_model.dart';

abstract class HelpInterface {


  Future<Either<CustomError, BaseModel>> addContact({
    required String name,
    required String email,
    required String phone,
    required String subject,
    required String message,

  });
}

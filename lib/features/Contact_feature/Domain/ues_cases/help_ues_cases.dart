import 'package:captien_omda_customer/core/model/base_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/Error_Handling/custom_error.dart';
import '../repoistory/help_interface.dart';

class HelpUesCases {
  final HelpInterface repositoryInterface;

  HelpUesCases(this.repositoryInterface);


  Future<Either<CustomError, BaseModel>> addContact({
    required String name,
    required String email,
    required String phone,
    required String subject,
    required String message,
  }) {
    return repositoryInterface.addContact(
        name: name,
        email: email,
        phone: phone,
        subject: subject,
        message: message,
       );
  }
}


import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Data_source/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/Error_Handling/custom_exception.dart';
import '../../../../core/model/base_model.dart';

abstract class HelpRemoteDataScoursInterface {

  Future<Either<CustomError, BaseModel>> addContact({
    required String name,
    required String email,
    required String phone,
    required String subject,
    required String message,
  });
}

class HelpRemoteDataScoursImp extends HelpRemoteDataScoursInterface {
  @override
  Future<Either<CustomError, BaseModel>> addContact(
      {required String name,
      required String email,
      required String phone,
      required String subject,
      required String message,
      }) async {
    try {
      FormData data = FormData();
      data.fields.add(MapEntry('name', name));
      data.fields.add(MapEntry('email', email));
      data.fields.add(MapEntry('phone', phone));
      data.fields.add(MapEntry('subject', subject));
      data.fields.add(MapEntry('message', message));

      await DioHelper.postData(url: ApiKeys.contactKey, data: data);

      return right(BaseModel());
    }on CustomException catch (ex) {
      return Left(ex.error);
    }
  }

}

import 'package:dartz/dartz.dart';
import '../../../../core/model/base_model.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../Domain/repoistory/help_interface.dart';
import '../data_scouresc/remote_data_scoures.dart';

class HelpRepository extends HelpInterface {
  final HelpRemoteDataScoursInterface remoteDataScoursInterface;

  HelpRepository(this.remoteDataScoursInterface);

  @override
  Future<Either<CustomError, BaseModel>> addContact(
      {required String name,
      required String email,
      required String phone,
      required String subject,
      required String message,
     }) {
    return remoteDataScoursInterface.addContact(
        name: name,
        email: email,
        phone: phone,
        subject: subject,
        message: message,
        );
  }

}

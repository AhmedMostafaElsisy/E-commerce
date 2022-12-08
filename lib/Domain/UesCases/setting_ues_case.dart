import 'package:dartz/dartz.dart';
import '../../Data/Interfaces/settings_interface.dart';
import '../../Data/Models/base_model.dart';
import '../../core/Error_Handling/custom_error.dart';

class SettingUesCase {
  final SettingInterfaceRepository repository;

  SettingUesCase({required this.repository});
  Future<Either<CustomError, BaseModel>> call() async {
    return await repository.getTermsAndConditions();
  }
}

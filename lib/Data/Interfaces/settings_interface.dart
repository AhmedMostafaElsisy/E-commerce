import 'package:default_repo_app/Data/Models/base_model.dart';

import 'base_interface.dart';

abstract class SettingInterfaceRepository extends BaseInterface{


  Future<BaseModel> getFqa();

  Future<BaseModel> getTermsAndConditions();
}

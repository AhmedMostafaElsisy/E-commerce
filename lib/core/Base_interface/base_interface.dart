import '../../Data/Models/base_model.dart';
import '../Error_Handling/custom_error.dart';

abstract class BaseInterface{
  BaseModel baseModel = BaseModel();
  CustomError? errorMsg;
  bool isError = false;
}